require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  include Devise::Test::ControllerHelpers
  describe 'Without login' do
    describe 'GET Product#index' do
      context 'without store_id' do
        it 'Get index' do
          get :index
          expect(response).to redirect_to stores_locations_path
        end
      end

      context 'with store_id' do
        let(:store) { create(:store) }
        it 'Get index' do
          cookies['store_id'] = store.id
          get :index
          expect(response).to have_http_status(:success)
        end
      end

      context 'with store_id and search' do
        let(:store) { create(:store) }
        let(:product) { create(:product) }

        it 'Get index' do
          cookies['store_id'] = store.id
          get :index, params: { search: product.code }
          expect(response).to have_http_status(:success)
        end
      end

      context 'with store_id and filter in cookie' do
        let(:store) { create(:store) }
        let(:product) { create(:product) }

        it 'Get index' do
          cookies['store_id'] = store.id
          cookies[:product_filters] = {price: '$10 - $25'}.to_json
          get :index
          expect(response).to have_http_status(:success)
        end
      end

      context 'with store_id and filter' do
        let(:store) { create(:store) }
        let(:product) { create(:product) }

        it 'Get index' do
          cookies['store_id'] = store.id
          get :index, params: { product_filters: { price: '$10 - $25' } }
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end
