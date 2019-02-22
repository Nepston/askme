class UsersController < ApplicationController
  def index
    @users = [
        User.new(
          id: 1,
          name: 'Nepston',
          username: 'nepston@gmail.com',
          avatar_url: 'http://www.picshare.ru/uploads/190221/VS37egkIj9.jpg'
        ),
        User.new(
            id: 2,
            name: 'Oleg',
            username: 'BBodw',
            avatar_url: ''
        )
    ]
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
    )

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('22.02.2019')),
      Question.new(text: 'Как жизнь?', created_at: Date.parse('22.02.2019')),
      Question.new(text: 'Как настроение?', created_at: Date.parse('22.02.2019')),
      Question.new(text: 'Почему Земля крутится?', created_at: Date.parse('22.02.2019')),
      Question.new(text: 'Кто Я?', created_at: Date.parse('22.02.2019'))
    ]

    @new_question = Question.new
  end
end
