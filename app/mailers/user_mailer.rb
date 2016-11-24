class UserMailer < ApplicationMailer

  def welcome(user)
    @user = user
    mail to: @user.email, subject: 'welcome to Gdutusma'
  end
end

