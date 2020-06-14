require 'rails_helper'

RSpec.describe PoliceDistrict, type: :model do
  describe 'factories' do
    it 'creates a valid factory' do
      expect(FactoryBot.build(:police_district)).to be_valid
    end
  end

  describe 'validations' do
    it 'requires name to be present' do
      expect(FactoryBot.build(:police_district, name: nil)).to_not be_valid
    end

    it 'requires slug to be unique' do
      FactoryBot.create(:police_district, slug: 'this-pd')
      duplicate = FactoryBot.build(:police_district, slug: 'this-pd')

      expect(duplicate).to_not be_valid
    end

    it 'requires slug to be lowercase with only dashes' do
      expect(FactoryBot.build(:police_district, slug: 'SDFalsd')).to_not be_valid
      expect(FactoryBot.build(:police_district, slug: 'hello_how')).to_not be_valid
      expect(FactoryBot.build(:police_district, slug: '@@@asdf')).to_not be_valid

      expect(FactoryBot.build(:police_district, slug: 'hello-1')).to be_valid
      expect(FactoryBot.build(:police_district, slug: 'hell-o')).to be_valid
    end

    it 'requires timezone be set and valid US timezone' do
      expect(FactoryBot.build(:police_district, timezone: nil)).to_not be_valid
      expect(FactoryBot.build(:police_district, timezone: 'asldfkasfd')).to_not be_valid
      expect(FactoryBot.build(:police_district, timezone: 'Brisbane')).to_not be_valid

      expect(FactoryBot.build(:police_district, timezone: 'Pacific Time (US & Canada)')).to be_valid
    end
  end

  describe 'setting .slug' do
    context 'when model is invalid' do
      it 'does not set slug on the item' do
        district = FactoryBot.build(:police_district, name: nil, slug: nil)
        district.save
        expect(district.slug).to be_empty
      end
    end

    context 'when model is valid' do
      it 'sets a parameterized version of name as slug' do
        district = FactoryBot.create(:police_district, name: 'Police Department', slug: nil)
        expect(district.slug).to eq('police-department')
      end
    end

    context 'when updating model' do
      it 'validates but honors provided slug' do
        district = FactoryBot.create(:police_district, name: 'Police Department', slug: nil)

        district.slug = 'asdlfSdkGJLKSDG'
        expect(district).to_not be_valid

        district.slug = 'valid-slug'
        expect(district).to be_valid
      end
    end
  end

  describe '#readable_budget' do
    context 'when present' do
      it 'returns amount in billions' do
        district = FactoryBot.create(:police_district, fy_2019_policing_budget: 1_900_600_000)
        expect(district.readable_budget).to eq('1.901B')
      end

      it 'returns amount in millions, rounded to nearest' do
        district = FactoryBot.create(:police_district, fy_2019_policing_budget: 190_590_000)
        expect(district.readable_budget).to eq('190.6M')
      end

      it 'handles amounts under 1 mil' do
        district = FactoryBot.create(:police_district, fy_2019_policing_budget: 600_000)
        expect(district.readable_budget).to eq('600K')
      end
    end

    context 'when not present' do
      it 'returns "---"' do
        district = FactoryBot.create(:police_district, fy_2019_policing_budget: nil)
        expect(district.readable_budget).to eq('---')
      end
    end
  end

  describe '#next_meeting' do
    context 'when there are no future meetings' do
      it 'returns nil' do
        district = FactoryBot.create(:police_district)
        meeting_a_while_ago = FactoryBot.create(:meeting, police_district: district, event_datetime: Date.today - 10.days)
        recent_meeting = FactoryBot.create(:meeting, police_district: district, event_datetime: Date.today - 5.days)

        expect(district.next_meeting).to be_nil
      end
    end

    context 'where there are future meetings' do
      it 'returns the soonest one' do
        district = FactoryBot.create(:police_district)
        far_meeting = FactoryBot.create(:meeting, police_district: district, event_datetime: Date.today + 10.days)
        soon_meeting = FactoryBot.create(:meeting, police_district: district, event_datetime: Date.today + 5.days)

        expect(district.next_meeting).to eq soon_meeting
      end
    end
  end
end
