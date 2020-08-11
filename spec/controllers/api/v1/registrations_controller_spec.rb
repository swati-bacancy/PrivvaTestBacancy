require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before :each do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  # describe 'Signup' do
  #   # let(:user) { create(:user) }
  #   context 'Create User' do
  #     let(:user) do
  #       post :create, params: {
  #         user: attributes_for(:user)
  #       }
  #     end
  #       # expect(response).to have_http_status(:success)
  #   end
  # end
  describe 'POST Client#create' do
    context 'with valid attributes' do
      let(:user) do
        post :create, params: {
          user: attributes_for(:user)
        }
      end

	    it { expect { user }.to change(User, :count).by(1) }
    end

    context 'with invalid attributes' do
      let(:user1) do
        post :create, params: {
          user: build(:user, :invalid).attributes
        }
      end

      it { expect { user1 }.to change(User, :count).by(0) }
    end

    context 'params not exists' do
      let(:user1) do
        post :create, params: {
        }
      end

      it { expect { user1 }.to change(User, :count).by(0) }
    end
  end
end
