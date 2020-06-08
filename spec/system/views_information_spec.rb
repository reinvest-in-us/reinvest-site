require 'rails_helper'

RSpec.describe 'information viewing' do
  before do
    PoliceDistrict.find_or_initialize_by(
      slug: 'san-francisco',
    ).update(
      name: 'San Francisco',
      fy_2019_policing_budget: 950_000_000,
    )
  end

  it 'shows index of all jurisdictions' do
    visit '/'

    expect(page).to have_content('Show up. Defund violence.')

    within '#district-san-francisco' do
      expect(page).to have_content('San Francisco')
      expect(page).to have_content('$950M')
    end
  end
end