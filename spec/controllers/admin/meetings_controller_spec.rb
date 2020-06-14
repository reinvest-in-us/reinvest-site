require 'rails_helper'

RSpec.describe Admin::MeetingsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:district) { FactoryBot.build(:police_district, slug: 'oakland', timezone: 'Pacific Time (US & Canada)') }
  let!(:meeting) { FactoryBot.create(:meeting, police_district: district) }

  context 'when user is signed in' do
    before do
      sign_in user
    end

    describe '#create' do
      let(:valid_params) do
        {
          meeting: {
            'event_datetime(1i)' => '2020',
            'event_datetime(2i)' => '6',
            'event_datetime(3i)' => '14',
            'event_datetime(4i)' => '4',
            'event_datetime(5i)' => '0',
            phone_number: 'asdf',
            agenda_link: 'asfd'
          },
          police_district_id: district.slug
        }
      end

      it 'converts datetime from district timezone to UTC before storing' do
        expect do
          post :create, params: valid_params
        end.to change(Meeting, :count).by(1)

        meeting = Meeting.last
        expect(meeting.event_datetime).to eq(DateTime.new(2020,6,14,11,0,0,'0'))
      end
    end
  end
end