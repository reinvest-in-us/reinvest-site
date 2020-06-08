require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'factories' do
    it 'creates a valid factory' do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end

  describe 'validations' do
    it 'requires email to be unique' do
      FactoryBot.create(:user, email: 'hi@example.com')
      duplicate_user = FactoryBot.build(:user, email: 'hi@example.com')

      expect(duplicate_user).to_not be_valid
    end
  end
end
