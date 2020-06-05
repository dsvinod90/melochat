# frozen_string_literal: true

class Admins::RegistrationsController < Devise::RegistrationsController
  layout 'application'
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

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
