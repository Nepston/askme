class Tag < ApplicationRecord

  VALID_REGEX = /\#[[:word:]]+/i

  belongs_to :question
  before_validation :downcase

  validates :question, :value, presence: true
  validates :value, length: { maximum: 255 },
            format: { with: VALID_REGEX },
            uniqueness: { scope: :question_id }

  private

  def downcase
    value.downcase! if value.present?
  end

end
