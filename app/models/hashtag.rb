class Hashtag < ApplicationRecord
  has_and_belongs_to_many :questions

  validates :value, presence: true, length: { maximum: 255 }

  private

end
