class Question < ApplicationRecord

  belongs_to :user
  belongs_to :author, class_name: "User", optional: true

  validates :text, :user, presence: true
  validates :text, length: { maximum: 255 }

  before_save :add_hashtags, on: [:create, :update]
  after_commit :reset_hashtags, on: :update

  has_and_belongs_to_many :hashtags, dependent: :destroy

  def extract_hashtags
    [text, answer].to_s.scan(/[\#]([[:word:]]+)/i).flatten.map(&:downcase)
  end

  def add_hashtags
    self.hashtags = self.extract_hashtags.map do |tag|
      Hashtag.find_or_create_by(value: tag)
    end
  end

  def reset_hashtags
    Hashtag.where("question_id = ? AND NOT IN ?", self.id, self.extract_hashtags).destroy_all
  end
end

