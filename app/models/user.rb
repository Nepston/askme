require 'openssl'

class User < ApplicationRecord
  #параметры работы модуля шифрования паролей
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_USERNAME_REGEX = /\A\w+\z/i
  COLOR_REGEX = /\A#([\da-f]{3}){1,2}\z/i

  has_many :questions, dependent: :destroy
  has_many :authored_questions, class_name: "Question",
           foreign_key: "author_id", dependent: :nullify

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: { case_sensitive: false }
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :username, length: { maximum: 40 }
  validates :username, format: { with: VALID_USERNAME_REGEX }
  validates :bg_color, format: { with: COLOR_REGEX }, allow_blank: true

  before_validation :downcase

  attr_accessor :password

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_save :encrypt_password

  def downcase
    email.downcase! if email.present?
    username.downcase! if username.present?
  end

  def encrypt_password
    if self.password.present?
      #создаем т.н. "соль" - рандомная строка усложняющая задачу хакерам
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      #создаем хэш пароля - длинная уникальная строка, из которой невозможно восстановить
      # исходный пароль
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  #служебный метод, преобразующий бинарную строку в 16-ричный формат, для удобства хранения
  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email) #находим юзера по email'у

    #сравниваем password_hash (оригинальный пароль никуда не сохраняем)
    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password,
                                                                                             user.password_salt,
                                                                                             ITERATIONS, DIGEST.length,
                                                                                             DIGEST))
      user
    else
      nil
    end
  end
end
