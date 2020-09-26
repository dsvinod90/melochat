# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def newsletter
    @user = params[:user]
    unsubscribe_url = unsubscribe_url(@user.token)
    headers['List-Unsubscribe'] = "<#{unsubscribe_url}>"
    mail(to: @user.email, subject: 'Hypocryte - This week\'s newsletter')
  end
end
