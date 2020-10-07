# frozen_string_literal: true

module Admins
  class RegistrationsController < Devise::RegistrationsController
    layout 'application'

    def create
      super
      Services::CreateAdminRole.new(@admin.id, params[:admin][:role_id]).process
    end
  end
end
