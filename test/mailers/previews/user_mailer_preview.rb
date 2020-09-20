# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def newsletter
    UserMailer.with(user: User.first).newsletter
  end
end
