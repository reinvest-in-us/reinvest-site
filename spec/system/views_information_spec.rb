require 'rails_helper'

RSpec.describe 'information viewing' do
  before do
    district = FactoryBot.create(:police_district,
                                 name: 'Down town',
                                 slug: 'down-town',
                                 total_police_department_budget: 950_000_000,
                                 timezone: 'Pacific Time (US & Canada)')

    FactoryBot.create(:meeting,
                      police_district: district,
                      event_datetime: DateTime.new(2025,6,20,5,30,00, '-7'))

    FactoryBot.create(:meeting,
                      police_district: district,
                      event_datetime: DateTime.new(2022,6,30,11,30,00, '-7'))
  end

  it 'shows index of all jurisdictions' do
    visit '/'

    expect(page).to have_content('Show up.')
    expect(page).to have_content('Defund violence.')

    within '#district-down-town' do
      expect(page).to have_content('Down town')
      expect(page).to have_content('$950M')
      expect(page).to have_content('Jun 30, 2022 @ 11:30am')
      expect(page).to have_link('Call in to comment')
    end
  end
end
