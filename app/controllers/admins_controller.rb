# frozen_string_literal: true

class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users  = User.all
    @admins = Admin.all
  end

  def send_newsletters
    user_ids = params[:user_id]
    if user_ids.present? && user_ids != 'all'
      SendNewsletterWorker.perform_async(user_ids)
      redirect_to(admins_path, flash: { success: I18n.t('admin.newsletter_sent') })
    elsif user_ids == 'all'
      all_user_ids = User.all.pluck(:id)
      SendNewsletterWorker.perform_async(all_user_ids)
      redirect_to(admins_path, flash: { success: I18n.t('admin.newsletter_sent') })
    else
      redirect_to(admins_path, flash: { alert: I18n.t('admin.users_not_selected') })
    end
  end
end
