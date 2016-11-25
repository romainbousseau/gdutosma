class UserMailer < ApplicationMailer

  def welcome(user)
    @user = user
    mail to: @user.email, subject: 'welcome to Gdutusma'
  end

  def recap(user)
    @user = user
    mail to: @user.email, subject: 'Recap of your order'
  end
end

