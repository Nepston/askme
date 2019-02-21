class UsersController < ApplicationController
  def index
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Marat',
      username: 'Nepston',
      email: 'nepston@gmail.com',
      avatar_url: 'http://www.picshare.ru/uploads/190221/VS37egkIj9.jpg',
      password: '321qwe'
    )
  end
end
