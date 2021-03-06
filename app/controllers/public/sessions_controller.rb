# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_inactive_member, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end
  def after_sign_in_path_for(resource)
    root_path
  end

  def new_guest
    member = Member.guest
    sign_in member
    redirect_to member_path(current_member), notice: 'ゲストユーザーとしてログインしました。'
  end
  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  protected

  def reject_inactive_member
    @member = Member.find_by(email: params[:member][:email])
    if @member
      if @member.valid_password?(params[:member][:password]) && @member.is_deleted
        redirect_to new_member_registration_path
      end
    end
  end

end
