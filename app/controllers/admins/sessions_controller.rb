# frozen_string_literal: true

module Admins
  class SessionsController < Devise::SessionsController
    layout 'application'
    # before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    def new
      super
    end

    # POST /resource/sign_in
    def create
      super
    end

    # DELETE /resource/sign_out
    def destroy
      super
    end
  end
end
