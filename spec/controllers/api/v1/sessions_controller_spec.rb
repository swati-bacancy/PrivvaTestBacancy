require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before :each do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST Session#create' do
    let(:user) { create(:user) }
    context 'with valid attributes' do
      it 'login' do
        post :create, params: {
          sign_in: { email: user.email, password: 'password'}
        }
      end
      it { expect(response).to have_http_status(:success) }
    end

    context 'with invalid attributes' do
      it 'login' do
        post :create, params: {
          sign_in: { email: user.email, password: 'password1'}
        }
      end
      it { expect(response).to have_http_status(:success) }
    end
  end

  describe 'DELETE Session#destroy' do
  let(:user) { create(:user) }
  context 'with valid attributes' do
    it 'logout' do
      @request.headers['AUTH-TOKEN'] = user.authentication_token

      delete :destroy
    end
    it { expect(response).to have_http_status(:success) }
  end

  context 'with invalid attributes' do
    it 'logout' do
      @request.headers['AUTH-TOKEN'] = 'test'

      delete :destroy
    end
    it { expect(response).to have_http_status(:success) }
  end
end
end
