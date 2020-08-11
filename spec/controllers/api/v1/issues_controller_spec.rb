require 'rails_helper'

RSpec.describe Api::V1::IssuesController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) { create(:user) }

  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
    @request.headers['AUTH-TOKEN'] = user.authentication_token
  end

  describe 'GET issue#index' do
    before { create(:issue) }
    context 'without page' do
      it 'Get index' do
        get :index, params: { page: 1, per_page: 2 }, format: :json
        expect(response).to have_http_status(:success)
      end
    end

    context 'with page' do
      it 'Get index' do
        get :index, format: :json
        expect(response).to have_http_status(:success)
      end
    end

    context 'with search' do
      it 'Get index' do
        get :index, params: { search: 'test'}, format: :json
        expect(response).to have_http_status(:success)
      end
    end

    context 'with sortable' do
      it 'Get index' do
        get :index, params: { sortable_columns: 'description'}, format: :json
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET issue#show' do
    let(:issue) { create(:issue) }
    it 'Get show' do
      get :show, params: { id: issue.id }, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST issue#create' do
    context 'with valid attributes' do
      let(:user) { create(:user) }
      let(:issue) do
        post :create, params: {
          issue: attributes_for(:issue)
        }
      end
	    it { expect { issue }.to change(Issue, :count).by(1) }
    end

    context 'with invalid attributes' do
      let(:issue) do
        post :create, params: {
          issue: attributes_for(:issue, :invalid)
        }
      end

      it { expect { issue }.not_to change(Issue, :count) }
    end
  end
end
