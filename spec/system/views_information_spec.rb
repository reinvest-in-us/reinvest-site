require 'rails_helper'

RSpec.describe 'information viewing' do
  before do
    district_one = FactoryBot.create(:police_district,
                                 name: 'Down town',
                                 slug: 'down-town',
                                 total_police_department_budget: 950_000_000,
                                 decision_makers_text: 'Some people decide on these things',
                                 timezone: 'Pacific Time (US & Canada)')

    district_two = FactoryBot.create(:police_district,
                                 name: 'Stu Ville',
                                 slug: 'stu-ville',
                                 total_police_department_budget: 10_000_000,
                                 timezone: 'Pacific Time (US & Canada)')

    FactoryBot.create(:meeting,
                      police_district: district_one,
                      event_datetime: DateTime.new(2025,6,20,5,30,00, '-7'))

    FactoryBot.create(:meeting,
                      police_district: district_two,
                      event_datetime: DateTime.new(2010,6,30,11,30,00, '-7'))
  end

  it 'shows districts with upcoming meetings, and allows visiting district info page' do
    visit '/'

    expect(page).to have_content('Reinvest in us.')

    within '[data-spec=upcoming-meetings]' do
      expect(page).to have_content('Upcoming meetings')
      expect(page).to have_content('Down town')
      expect(page).to have_content('$950M')
      expect(page).to have_content('Friday, June 20 at 5:30am')
    end

    click_on 'Down town'

    expect(page).to have_content('Down town')
    expect(page).to have_content('$950M')
    expect(page).to have_content('Upcoming meeting')
    expect(page).to have_content('Friday, June 20 at 5:30am')
    expect(page).to have_content('Some people decide on these things')
    expect(page).to have_link('Add to calendar')
  end

  it 'shows districts with past meetings, and allows visiting district info page' do
    visit '/'

    within '[data-spec=recent-meetings]' do
      expect(page).to have_content('Recent meetings')
      expect(page).to have_content('Stu Ville')
      expect(page).to have_content('$10M')
      expect(page).to have_content('Wednesday, June 30 at 11:30am')
    end

    click_on 'Stu Ville'

    expect(page).to have_content('Stu Ville')
    expect(page).to have_content('$10M')
    expect(page).to have_content('Last meeting')
    expect(page).to have_content('Wednesday, June 30 at 11:30am')
    expect(page).to_not have_link('Add to calendar')
    expect(page).to have_content('This meeting has ended.')
    expect(page).to have_content('An archive of the meeting page\'s contents is shown below.')
  end

  it 'has an about page' do
    visit '/about'

    expect(page).to have_content('About this site')
  end
end
