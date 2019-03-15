class CreateJoinTableHashtagsQuestions < ActiveRecord::Migration[5.2]
  def change
    create_join_table :hashtags, :questions do |t|
      t.index [:hashtag_id, :question_id], unique: true
      # t.index [:question_id, :hashtag_id]
    end
  end
end
