# frozen_string_literal: true

module Services
  class SendgridMailer
    def self.send(to, subsitutions, template_id = 'd-b22126f8e5aa40f083a6b004dacecda3')
      user = User.where(email: to).last
      data = {
        "personalizations": [
          {
            "to": [
              {
                "email": to
              }
            ],
            "dynamic_template_data": subsitutions.merge(unsubscribe: Rails.application.routes.url_helpers.unsubscribe_url(user.token, host: 'https://www.hypocryte.monster'))
          }
        ],
        "from": {
          "email": 'mail@hypocryte.monster'
        },
        "template_id": template_id
      }
      sg = SendGrid::API.new(api_key: Rails.application.credentials[:sendgrid][:api_key])
      begin
        response = sg.client.mail._("send").post(request_body: data)
        return response.status_code
      rescue Exception => e
        puts e.message
      end
    end
  end
end
