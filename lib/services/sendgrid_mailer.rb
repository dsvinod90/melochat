# frozen_string_literal: true

module Services
  class SendgridMailer
    include ActiveModel::Validations

    validates_presence_of :user, :template
    validate :user_should_be_subscribed

    attr_reader :user_id, :substitutions, :template_code

    def initialize(user_id, substitutions, template_code)
      @user_id         = user_id
      @substitutions   = substitutions
      @template_code   = template_code
    end

    def send_templated_email
      return unless valid?

      mail_object = SendGrid::API.new(api_key: Rails.application.credentials[:sendgrid][:api_key])
      begin
        response = mail_object.client.mail._('send').post(request_body: data)
        response.status_code
      rescue Exception => e
        errors.add(:base, e.message)
        false
      end
    end

    def data
      {
        personalizations: [
          {
            to: [{ email: user.email }],
            dynamic_template_data: substitutions.merge(unsubscribe: unsubscribe_url)
          }
        ],
        from: { email: host_email, name: 'Hypocryte' },
        template_id: template.template_id
      }
    end

    private

    def user
      @user ||= User.find_by(id: user_id)
    end

    def template
      @template ||= SendgridTemplate.where(code: template_code).latest_versions.first
    end

    def hostname
      Rails.application.credentials[:host][:name]
    end

    def host_email
      Rails.application.credentials[:host][:email]
    end

    def unsubscribe_url
      Rails.application.routes.url_helpers.unsubscribe_url(user.token, host: hostname)
    end

    def user_should_be_subscribed
      return unless user

      return if user.subscribed

      errors.add(:base, I18n.t('sendgrid.user_not_subscribed'))
      false
    end
  end
end
