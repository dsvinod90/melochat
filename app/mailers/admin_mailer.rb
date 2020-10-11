# frozen_string_literal: true

class AdminMailer < Devise::Mailer
  include ActiveModel::Validations

  attr_reader :admin

  def confirmation_instructions(record, _token, _opts = {})
    @admin = record
    mail_object = SendGrid::API.new(api_key: Rails.application.credentials[:sendgrid][:api_key])
    begin
      response = mail_object.client.mail._('send').post(request_body: data)
      response.status_code
    rescue Exception => e
      errors.add(:base, e.message)
      false
    end
  end

  private

  def data
    {
      personalizations: [
        {
          to: [{ email: admin.email }],
          dynamic_template_data: {
            admin: {
              name: admin.name,
              confirmation_url: confirmation_url
            }
          }
        }
      ],
      from: { email: host_email, name: 'Hypocryte' },
      template_id: template.template_id
    }
  end

  def template
    @template ||= SendgridTemplate.where(code: 'HYP_CONF_MAIL').active.latest_versions.first
  end

  def confirmation_url
    Rails.application.routes.url_helpers.admin_confirmation_url(
      confirmation_token: admin.confirmation_token,
      host: hostname
    )
  end

  def hostname
    Rails.application.credentials[:host][:name]
  end

  def host_email
    Rails.application.credentials[:host][:email]
  end
end
