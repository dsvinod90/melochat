# frozen_string_literal: true

class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def show_admins_list
    @admins = Admin.all
  end

  def show_users_list
    @users = User.all
  end

  def email_templates
    @templates = SendgridTemplate.all
  end

  def newsletter_settings
    @users = User.where(subscribed: true)
  end

  def send_newsletters
    user_ids = params[:user_id]
    if user_ids.present? && user_ids != 'all'
      SendNewsletterWorker.perform_async(user_ids)
      redirect_to(newsletter_settings_admins_path, flash: { success: I18n.t('admin.newsletter_sent') })
    elsif user_ids == 'all'
      all_user_ids = User.all.pluck(:id)
      SendNewsletterWorker.perform_async(all_user_ids)
      redirect_to(newsletter_settings_admins_path, flash: { success: I18n.t('admin.sent_to_all') })
    else
      redirect_to(newsletter_settings_admins_path, flash: { alert: I18n.t('admin.users_not_selected') })
    end
  end

  def update_templates
    template_id = params[:template_id]
    activation_status = params[:active]
    template = SendgridTemplate.find_by(id: template_id)
    if template.update_attributes(active: activation_status)
      redirect_to(email_templates_admins_path, flash: { success: I18n.t('admin.template_updated') })
    else
      redirect_to(email_templates_admins_path, flash: { alert: template.errors.full_messages })
    end
  end
end
