class Question < ApplicationRecord

  belongs_to :user
  belongs_to :author, class_name: "User", optional: true

  validates :text, :user, presence: true
  validates :text, length: { maximum: 255 }

  before_save :add_hashtags, on: [:create, :update]
  after_commit :delete_hashtags, on: [:update, :destroy]

  has_and_belongs_to_many :hashtags, dependent: :destroy

  def extract_hashtags
    [text, answer].to_s.scan(/[\#]([[:word:]]+)/i).flatten.uniq.map(&:downcase)
  end

  def add_hashtags
    self.hashtags = self.extract_hashtags.map do |extr_tag|
      Hashtag.find_or_create_by(value: extr_tag)
    end
  end

  def delete_hashtags
    Hashtag.includes(:questions).where(questions: { id: nil }).destroy_all
  end
end
