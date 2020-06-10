require 'rails_helper'

RSpec.describe 'information management' do
  let!(:user) { FactoryBot.create(:user, email: 'user@example.com', password: 'qwerty') }
  let!(:district) { FactoryBot.create(:police_district, name: 'Berkeley', slug: 'berkeley') }

  scenario 'adding a new district' do
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

  scenario 'adding events to an existing district' do
    login_as(user)

    visit admin_root_path

    click_on 'Berkeley'
    click_on 'Add budget meeting'

    fill_in 'Call-in phone number', with: '555-123-4567'
    select '2020',  :from => "meeting_event_datetime_1i" #year
    select 'June',  :from => "meeting_event_datetime_2i" #month
    select '10', :from => "meeting_event_datetime_3i" #day
    select '02',  :from => "meeting_event_datetime_4i" #hour
    select '30',  :from => "meeting_event_datetime_5i" #minute

    click_on 'Add'

    expect(page).to have_content('555-123-4567')
    expect(page).to have_content('Jun 10, 2020 @ 2:30am')
  end
end