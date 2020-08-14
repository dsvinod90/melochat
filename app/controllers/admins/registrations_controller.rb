# frozen_string_literal: true

module Admins
  class RegistrationsController < Devise::RegistrationsController
    layout 'application'

    # GET /resource/sign_up
    def new
      super
    end

    # POST /resource
    def create
      super
    end

    # GET /resource/edit
    def edit
      super
    end

    # PUT /resource
    def update
      super
    end

    # DELETE /resource
    def destroy
      super
    end
  end
end
