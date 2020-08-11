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
    context 'without login' do
      it 'Get index' do
        @request.headers['AUTH-TOKEN'] = nil
        get :index, params: { page: 1, per_page: 2 }, format: :json
        expect(response).to have_http_status(401)
      end
    end

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
          issue: build(:issue).attributes.merge('reporter_id' => user.id)
        }
      end
	    it { expect { issue }.to change(Issue, :count).by(1) }
    end

    context 'with invalid attributes' do
      let(:issue) do
        post :create, params: {
          issue: build(:issue, :invalid).attributes
        }
      end

      it { expect { issue }.not_to change(Issue, :count) }
    end
  end

  describe 'PUT issue#update' do
    let!(:user) { create(:user) }
    let!(:issue) { create(:issue).attributes.merge('reporter_id' => user.id) }
    context 'with valid attributes' do
      it 'updates the issue' do
        put :update, params: {
          id: issue["id"], issue: { reporter_id: user.id }
        }
        expect(response).to have_http_status(:success)

      end
    end

    context 'with invalid attributes' do
      context 'with valid attributes' do
        it 'updates the issue' do
          put :update, params: {
            id: issue["id"], issue: { reporter_id: nil }
          }
          expect(response).to have_http_status(422)
        end
      end
    end
  end

  describe 'delete issue#destroy' do
    let!(:user) { create(:user) }
    let!(:issue) { create(:issue).attributes.merge('reporter_id' => user.id) }
    it 'destroy the issue' do
      delete :destroy, params: {
        id: issue["id"]
      }
      expect(response).to have_http_status(:success)
    end
  end
end
