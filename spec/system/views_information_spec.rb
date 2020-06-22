require 'rails_helper'

RSpec.describe 'information viewing' do
  before do
    district = FactoryBot.create(:police_district,
                                 name: 'Down town',
                                 slug: 'down-town',
                                 total_police_department_budget: 950_000_000,
                                 decision_makers_text: 'Some people decide on these things',
                                 timezone: 'Pacific Time (US & Canada)')

    FactoryBot.create(:meeting,
                      police_district: district,
                      event_datetime: DateTime.new(2025,6,20,5,30,00, '-7'))

    FactoryBot.create(:meeting,
                      police_district: district,
                      how_to_comment: 'Call in and talk',
                      event_datetime: DateTime.new(2022,6,30,11,30,00, '-7'))
  end

  it 'shows index of districts, and allows visiting district info page' do
    visit '/'

    expect(page).to have_content('Reinvest in us.')

    within '#district-down-town' do
      expect(page).to have_content('Down town')
      expect(page).to have_content('$950M')
      expect(page).to have_content('Thursday, June 30 at 11:30am')
    end

    click_on 'Down town'

    expect(page).to have_content('Down town')
    expect(page).to have_content('$950M')
    expect(page).to have_content('Thursday, June 30 at 11:30am')
    expect(page).to have_content('Some people decide on these things')
    expect(page).to have_content('Call in and talk')
    expect(page).to have_link('Add to calendar')
  end

  it 'has an about page' do
    visit '/about'

    expect(page).to have_content('About this site')
  end
end
