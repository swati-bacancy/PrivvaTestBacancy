# frozen_string_literal: true

class Api::V1::SessionsController < Devise::SessionsController
  before_action :sign_in_params, only: :create
  before_action :load_user, only: :create
  before_action :valid_token, only: :destroy
  skip_before_action :verify_signed_out_user, only: :destroy

  # sign in
  def create

    if @user.valid_password?(sign_in_params[:password])
      sign_in 'user', @user
      json_response('Signed in successfully', true, { user: @user }, 200)
    else
      json_response('Unauthorized', false, {}, 410)
    end
  end

  # logout
  def destroy
    sign_out @user
    @user.generate_new_authentication_token
    json_response('Log out successfully', true, {}, 400)
  end

  private

  def sign_in_params
    params.require(:sign_in).permit(:email, :password)
  end

  def load_user
    @user = User.find_for_database_authentication(email: sign_in_params[:email])
    @user || json_response('Cannot get user', false, {}, 400)
  end

  def valid_token
    @user = User.find_by authentication_token: request.headers['AUTH-TOKEN']
    @user || json_response('Invalid Token', false, {}, 400)
  end
end
