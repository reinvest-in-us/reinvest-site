require 'rails_helper'

RSpec.describe Admin::PoliceDistrictsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let!(:district) { FactoryBot.create(:police_district, slug: 'oakland', timezone: 'Pacific Time (US & Canada)') }

  context 'when user is signed in' do
    before do
      sign_in user
    end

    describe '#update' do
      it 'returns 404 if district not present' do
        expect do
          post :update, params: { id: 'asldkfjaslkfdj' }
        end.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    describe '#edit' do
      render_views

      it 'returns 404 if district not present' do
        expect do
          post :edit, params: { id: 'asldkfjaslkfdj' }
        end.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    describe '#destroy' do
      it 'returns 404 if district not present' do
        expect do
          post :update, params: { id: 'asldkfjaslkfdj' }
        end.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    describe '#show' do
      it 'returns 404 if district not present' do
        expect do
          get :show, params: { id: 'asldkfjaslkfdj' }
        end.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
end
