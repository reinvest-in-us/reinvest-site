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
    fill_in 'Total Police FY2019 Budget', with: '160,000,000'
    fill_in 'Total FY2019 City Budget', with: '1,000,000,000'
    fill_in 'Total FY2019 General Fund Budget', with: '50,000,000'
    fill_in 'Total FY2019 General Fund Spent on Police', with: '25,000,000'
    fill_in 'Decision makers text', with: 'The following people are decision makers.'

    fill_in 'police_district_law_enforcement_gets_more_than_1', with: 'Transit'
    fill_in 'police_district_law_enforcement_gets_more_than_1_dollars', with: '1000000'

    fill_in 'police_district_law_enforcement_gets_more_than_2', with: 'Education'
    fill_in 'police_district_law_enforcement_gets_more_than_2_dollars', with: '3000000'

    fill_in 'police_district_law_enforcement_gets_more_than_3', with: 'Parks'
    fill_in 'police_district_law_enforcement_gets_more_than_3_dollars', with: '5000000'

    click_on 'Create'

    expect(page).to have_text('BART PD')

    visit '/d/bart-pd'
    expect(page).to have_text('BART PD')
    expect(page).to have_content('The following people are decision makers.')

    expect(page).to have_content('Transit')
    expect(page).to have_content('1000000')

    within '[data-spec=general-fund]' do
      expect(page).to have_text "50%"
      expect(page).to have_text "of BART PD's 2019 General Fund was spent on law enforcement"
    end

    within '[data-spec=general-fund]' do
      expect(page).to have_text "50%"
      expect(page).to have_text "of BART PD's 2019 General Fund was spent on law enforcement"
    end

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
      fill_in 'Video conference link', with: 'https://example.com/meeting'
      select '2020',  :from => "meeting_event_datetime_1i" #year
      select 'June',  :from => "meeting_event_datetime_2i" #month
      select '10', :from => "meeting_event_datetime_3i" #day
      select '02 AM',  :from => "meeting_event_datetime_4i" #hour
      select '30',  :from => "meeting_event_datetime_5i" #minute

      fill_in 'Meeting agenda link', with: 'example.com'
      fill_in 'Agenda Details', with: 'First, transporation budget, then police budget'

      fill_in 'How to comment', with: "Do this.\nDo that.\n"

      click_on 'Create Meeting'

      expect(page).to have_content('555-123-4567')
      expect(page).to have_content('Jun 10, 2020 @ 2:30am')

      within('[data-spec=meetings]') { click_on 'Edit' }

      fill_in 'Call-in phone number', with: '515-111-1234'
      click_on 'Update Meeting'

      expect(page).to have_content('515-111-1234')

      visit '/d/berkeley'

      expect(page).to have_content('Do this.')
      expect(page).to have_content('Do that.')
      expect(page).to have_link("Review this meeting's agenda")
      expect(page).to have_link('Watch this meeting online')
      expect(page).to have_content('First, transporation budget, then police budget')
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
