class UserMailerPreview < ActionMailer::Preview

 def welcome
    user = User.first
    UserMailer.welcome(user)
end

end
