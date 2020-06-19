require 'rails_helper'

RSpec.describe 'information management' do
  let!(:user) { FactoryBot.create(:user, email: 'user@example.com', password: 'qwerty') }
  let!(:district) { FactoryBot.create(:police_district,
                                      timezone: 'Pacific Time (US & Canada)',
                                      name: 'Berkeley',
                                      slug: 'berkeley') }

  scenario 'adding a new district' do
    login_as(user)

    visit admin_root_path

    click_on 'Add a new district'

    fill_in 'Name', with: 'BART PD'
    fill_in 'FY2019 Budget', with: '160,000,000'
    fill_in 'Total City Budget', with: '1,000,000,000'
    fill_in 'General Fund Percent', with: '65'
    fill_in 'Decision makers', with: 'Cardamom Pod, Cumin Seed'
    fill_in 'How to comment', with: "Do this.\nDo that.\n"
    click_on 'Create'

    expect(page).to have_text('BART PD')

    visit '/d/bart-pd'
    expect(page).to have_text('BART PD')
    expect(page).to have_content('Cardamom Pod, Cumin Seed')
    expect(page).to have_content('Do this.')
    expect(page).to have_content('Do that.')

    visit '/admin/police_districts/bart-pd'
    expect(page).to have_text('Pacific Time (US & Canada)')
  end

  scenario 'editing a district' do
    login_as(user)

    visit admin_root_path

    click_on 'Berkeley'
    expect(page).not_to have_content('New District Name')

    click_on 'Edit'
    fill_in 'Name', with: "New District Name"
    click_on 'Update Police district'

    visit '/d/berkeley'
    expect(page).to have_content('New District Name')
  end

  scenario 'adding meetings to an existing district' do
    travel_to Date.parse('2020-06-03') do
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

      fill_in 'Meeting agenda link', with: 'example.com'

      click_on 'Create Meeting'

      expect(page).to have_content('555-123-4567')
      expect(page).to have_content('Jun 10, 2020 @ 2:30am')

      within('.district-card') { click_on 'Edit' }

      fill_in 'Call-in phone number', with: '515-111-1234'
      click_on 'Update Meeting'

      expect(page).to have_content('515-111-1234')

      visit '/d/berkeley'

      expect(page).to have_content("Review this meeting's agenda")
    end
  end

  scenario 'adding elected officials to an existing district' do
      login_as(user)

      visit admin_root_path

      click_on 'Berkeley'
      click_on 'Add elected official'

      fill_in 'Name', with: 'Some Official'
      fill_in 'Position', with: 'Bureaucrat'
      fill_in 'Re-election date', with: 'June 2021'
      fill_in 'List rank', with: 1

      click_on 'Create Elected official'

      expect(page).to have_content('Some Official')
      expect(page).to have_content('Bureaucrat')
      expect(page).to have_content('June 2021')

      within('[data-spec=officials]') { click_on 'Edit' }

      fill_in 'Name', with: 'New Name'
      click_on 'Update Elected official'

      expect(page).to have_content('New Name')
  end
end
