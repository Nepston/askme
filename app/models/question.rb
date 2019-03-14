class Question < ApplicationRecord

  belongs_to :user
  belongs_to :author, class_name: "User", optional: true

  validates :text, :user, presence: true
  validates :text, length: { maximum: 255 }

  has_many :tags
  #after_commit :modify_tags, on: [:destroy, :update]
  #after_commit :create_tags, on: :create

  private

  #def modify_tags

 # end

  #def create_tags

  #end

end
