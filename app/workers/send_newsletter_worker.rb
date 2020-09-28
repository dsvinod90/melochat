# frozen_string_literal: true

class SendNewsletterWorker
  include Sidekiq::Worker

  sidekiq_options queue: :default

  def perform(user_ids)
    user_ids.each do |user_id|
      user = User.find_by(id: user_id)
      service = Services::SendgridMailer.new(user_id, params(user), SendgridTemplate::TemplateMappings::NEWSLETTER)
      service.send_templated_email
    end
  end

  private

  def params(user)
    { user: { name: user.name } }
  end
end
