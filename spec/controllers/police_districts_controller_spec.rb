require 'rails_helper'

RSpec.describe PoliceDistrictsController, type: :controller do
  describe '#show' do
    it 'returns 404 if district not present' do
      expect do
        get :show, params: { slug: 'asldkfjaslkfdj' }
      end.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end
