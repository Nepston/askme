class Hashtag < ApplicationRecord

  REGEXP = /#[[:word:]]+/

  has_many :hashtags_questions
  has_many :questions, through: :hashtags_questions

  validates :value, presence: true, uniqueness: true

  def to_param
    value
  end
end
