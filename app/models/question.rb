class Question < ApplicationRecord

  belongs_to :user
  belongs_to :author, class_name: "User", optional: true

  validates :text, :user, presence: true
  validates :text, length: { maximum: 255 }

  has_many :hashtags_questions
  has_many :hashtags, through: :hashtags_questions

  before_save :extract_hashtags
  before_destroy :delete_hashtags

  def extract_hashtags
    hashtags_questions.clear

    "#{text} #{answer}".scan(Hashtag::REGEXP).flatten.uniq.map(&:downcase).each do |h|
      hashtags << Hashtag.find_or_create_by!(value: h)
    end
  end

  def delete_hashtags
    self.hashtags.destroy_all
    self.hashtags_questions.destroy_all
  end
end
