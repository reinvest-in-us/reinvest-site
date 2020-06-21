require 'rails_helper'

RSpec.describe Admin::MeetingsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let!(:district) { FactoryBot.create(:police_district, slug: 'oakland', timezone: 'Pacific Time (US & Canada)') }

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
        travel_to Date.parse('2020-6-13') do
          expect do
            post :create, params: valid_params
          end.to change(Meeting, :count).by(1)
        end
        meeting = Meeting.last
        expect(meeting.event_datetime).to eq(DateTime.new(2020,6,14,11,0,0,'0'))
      end
    end

    describe '#update' do
      let!(:meeting) { FactoryBot.create(:meeting, event_datetime: DateTime.new(2025,1,20,5,0,0,'7')) }

      let(:valid_params) do
        {
          meeting: {
            'event_datetime(1i)' => '2027',
            'event_datetime(2i)' => '6',
            'event_datetime(3i)' => '14',
            'event_datetime(4i)' => '4',
            'event_datetime(5i)' => '0',
            phone_number: 'asdf',
            agenda_link: 'asfd'
          },
          id: meeting.id,
          police_district_id: district.slug
        }
      end

      it 'converts datetime from district timezone to UTC before storing' do
        travel_to Date.parse('2020-06-03') do
          expect do
            post :update, params: valid_params
          end.to change{ meeting.reload.event_datetime }.to eq(DateTime.new(2027,6,14,11,0,0,'0'))
        end
      end
    end

    describe '#edit' do
      let!(:meeting) { FactoryBot.create(:meeting, event_datetime: DateTime.new(2025,1,20,11,0,0,0)) }

      render_views

      it 'converts time to district timezone, but strips timezone' do
        travel_to Date.parse('2020-06-03') do
          get :edit, params: { id: meeting.id, police_district_id: district.slug }
        end

        expect(response.body).to include('<option value="03" selected="selected">03 AM</option>')
      end
    end
  end
end
