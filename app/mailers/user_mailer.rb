class UserMailer < ApplicationMailer
  def newsletter
    @user = params[:user]
    mail(to: @user.email, subject: 'Hypocryte - This week\'s newsletter')
  end
end
