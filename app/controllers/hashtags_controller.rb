class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by!(value: params[:id])
    @questions = @hashtag.questions
  end
end