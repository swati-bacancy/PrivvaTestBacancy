# frozen_string_literal: true

class Api::V1::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_params_exists, only: :create

  # sign up
  def create
    user = User.new(user_params)
    if user.save
      json_response('Signed up successfully', true, { user: user }, 200)
    else
      json_response(
        'Something wrong', false, {}, 422,
        user.errors.full_messages
      )
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end

  def ensure_params_exists
    return if params[:user].present?

    json_response('Missing Params', false, {}, :bad_request)
  end
end
