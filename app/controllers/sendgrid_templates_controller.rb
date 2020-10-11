# frozen_string_literal: true

class SendgridTemplatesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @templates = SendgridTemplate.all
  end

  def new
    @template = SendgridTemplate.new
  end

  def create
    template = SendgridTemplate.new(create_or_update_params)
    if template.save
      redirect_to(sendgrid_templates_path, flash: { success: I18n.t('sendgrid_template.added_successfully') })
    else
      flash.now[:danger] = template.errors.full_messages.to_sentence
      render(:new)
    end
  end

  def edit
    @template = SendgridTemplate.find_by(id: params[:id])
  end

  def update
    template = SendgridTemplate.find_by(id: params[:id])
    if template.update_attributes(create_or_update_params)
      redirect_to(sendgrid_templates_path, flash: { success: I18n.t('admin.template_updated') })
    else
      redirect_to(email_templates_admins_path, flash: { alert: template.errors.full_messages })
    end
  end

  private

  def create_or_update_params
    params.require(:sendgrid_template).permit(:name, :code, :version, :template_id, :active)
  end
end
