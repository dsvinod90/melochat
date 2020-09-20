class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to(
        welcome_index_path,
        flash: { notice: 'You have successfully subscribed! Thank you for subscribing with us.' }
      )
    else
      flash.now[:danger] = user.errors.full_messages.to_sentence
      render(:new)
    end
  end

  def unsubscribe
    @user = User.find_by(token: params[:token])
  end

  def unsubscribe_user
    user = User.find_by(token: params[:token])
    if user.subscribed
      user.update_attributes(subscribed: false)
      redirect_to(
        welcome_index_path,
        flash: { notice: 'You have successfully unsubscribed! You will no longer receive emails from us.' }
      )
    else
      redirect_to(welcome_index_path, flash: { danger: 'You have already unsubscribed' })
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
