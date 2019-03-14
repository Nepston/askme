class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # http://guides.rubyonrails.org/security.html#cross-site-request-forgery-csrf
  protect_from_forgery with: :exception

  helper_method :current_user, :get_all_tags

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def reject_user
    redirect_to root_path, alert: 'Вам сюда нельзя!'
  end

  def get_all_tags
    @tags = Question.all.pluck(:text, :answer).flatten.compact
    @tags.map!{ |v| v.scan(/\#[[:word:]]+/i) }
    @tags.flatten!.uniq!
  end
end
