class ActualizeHashtags < ActiveRecord::Migration[5.2]
  def change
    HashtagsQuestion.destroy_all
    Hashtag.destroy_all

    Question.all.each do |q|
      q.extract_hashtags
    end
  end
end
