require 'rails_helper'

RSpec.describe 'information management' do
  let!(:user) { FactoryBot.create(:user, email: 'user@example.com', password: 'qwerty') }

  it 'can add and edit a district' do
    login_as(user)

    visit admin_root_path

    click_on 'Add a new district'

    fill_in 'Name', with: 'BART PD'
    fill_in 'FY2019 Budget', with: '160,000,000'
    click_on 'Create'

    expect(page).to have_text('BART PD')

    visit '/d/bart-pd'
    expect(page).to have_text('BART PD')
  end
end