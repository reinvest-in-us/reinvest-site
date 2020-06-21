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
    it 'returns amount in billions' do
      district = FactoryBot.create(:police_district, total_police_department_budget: 1_900_600_000)
      expect(district.readable_budget).to eq('1.901B')
    end

    it 'returns amount in millions, rounded to nearest' do
      district = FactoryBot.create(:police_district, total_police_department_budget: 190_590_000)
      expect(district.readable_budget).to eq('190.6M')
    end

    it 'handles amounts under 1 mil' do
      district = FactoryBot.create(:police_district, total_police_department_budget: 600_000)
      expect(district.readable_budget).to eq('600K')
    end
  end

  describe '#next_meeting' do
    let(:district) { FactoryBot.create(:police_district) }

    context 'when there are no future meetings' do
      it 'returns nil' do
        travel_to Date.today - 10.days do
          meeting_a_while_ago = FactoryBot.create(:meeting, police_district: district, event_datetime: Date.today)
          recent_meeting = FactoryBot.create(:meeting, police_district: district, event_datetime: Date.today + 5.days)
        end


        expect(district.next_meeting).to be_nil
      end
    end

    context 'where there are future meetings' do
      it 'returns the soonest one' do
        far_meeting = FactoryBot.create(:meeting, police_district: district, event_datetime: Date.today + 10.days)
        soon_meeting = FactoryBot.create(:meeting, police_district: district, event_datetime: Date.today + 5.days)

        expect(district.next_meeting).to eq soon_meeting
      end
    end

    context 'where there are future meetings without required info' do
      it 'returns nil' do
        soon_meeting = FactoryBot.create(:meeting, police_district: district, how_to_comment: '', event_datetime: Date.today + 5.days)

        expect(district.next_meeting).to be_nil
      end
    end

    context 'where there is a meeting in progress' do
      it 'returns the in progress meeting' do
        in_progress_meeting = FactoryBot.create(:meeting, police_district: district, event_datetime: Time.zone.now + 1.minute)

        travel_to Time.zone.now + 5.hours do
          expect(district.next_meeting).to eq in_progress_meeting
        end

        travel_to Time.zone.now + 12.hours do
          expect(PoliceDistrict.find(district.id).next_meeting).to be_nil
        end
      end
    end
  end

  describe '#with_upcoming_meetings' do
    let!(:sf) { FactoryBot.create(:police_district, name: 'San Francisco') }
    let!(:oakland) { FactoryBot.create(:police_district, name: 'Oakland') }
    let!(:sd) { FactoryBot.create(:police_district, name: 'San Diego') }

    before do
      FactoryBot.create(:meeting, police_district: sf, event_datetime: Date.today + 5.days)

      FactoryBot.create(:meeting, police_district: sd, event_datetime: Date.today + 1.day)
    end

    it 'only shows districts with upcoming meetings' do
      query = PoliceDistrict.with_upcoming_meetings
      expect(query).to eq [sd, sf]
    end
  end

  describe '#general_fund_spent_on_police_percentage' do
    context 'when both total_general_fund_budget and total_police_paid_from_general_fund_budget are present' do
      it 'calculates the percentage, rounded to neareset 1%' do
        district = FactoryBot.build(:police_district,
                                    total_general_fund_budget: 1000,
                                    total_police_paid_from_general_fund_budget: 165)

        expect(district.general_fund_spent_on_police_percentage).to eq(17)
      end
    end

    context 'when total_general_fund_budget is nil' do
      it 'returns nil' do
        district = FactoryBot.build(:police_district,
                                    total_general_fund_budget: nil,
                                    total_police_paid_from_general_fund_budget: 10_000)

        expect(district.general_fund_spent_on_police_percentage).to be_nil
      end
    end

    context 'when total_police_paid_from_general_fund_budget is nil' do
      it 'returns nil' do
        district = FactoryBot.build(:police_district,
                                    total_general_fund_budget: 10_000,
                                    total_police_paid_from_general_fund_budget: nil)

        expect(district.general_fund_spent_on_police_percentage).to be_nil
      end
    end
  end
end
