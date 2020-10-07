# frozen_string_literal: true

module Admins
  class SessionsController < Devise::SessionsController
    layout 'application'
    def create
      resource = resource_class.where(email: params[:admin][:email]).last
      return super unless resource

      if resource.confirmed?
        super
      else
        resource.resend_confirmation_instructions
        redirect_to(welcome_index_path, flash: { notice: 'Email confirmation has been sent.' })
      end
    end
  end
end
