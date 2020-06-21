require 'rails_helper'

RSpec.describe Meeting, type: :model do
  describe 'factories' do
    it 'builds valid factories' do
      expect(FactoryBot.build(:meeting)).to be_valid
    end
  end

  describe '.formatted_event_datetime' do
    it 'returns the formatted string in the district timezone' do
      travel_to DateTime.new(2009,10,20,13,30,00) do
        meeting = FactoryBot.build(:meeting, event_datetime: DateTime.new(2010,10,20,13,30,00))
        expect(meeting.formatted_event_datetime).to include('Oct 20, 2010 @ ')
        expect(meeting.formatted_event_datetime).to include('6:30am')
      end
    end

    context 'when event_datetime is nil' do
      it 'returns nil' do
        meeting = FactoryBot.build(:meeting, event_datetime: nil)
        expect(meeting.formatted_event_datetime).to be_nil
      end
    end
  end

  describe 'datetime_in_future' do
    it 'invalidates if event is in the past' do
      meeting = FactoryBot.build(:meeting, event_datetime: DateTime.new(2010,10,20,13,30,00))
      expect(meeting.valid?).to eq false
    end
  end

  describe 'prefixing links' do
    it 'adds http if not prefixed already' do
      meeting = FactoryBot.build(:meeting, agenda_link: 'google.com')
      expect(meeting.agenda_link_prefixed).to eq 'http://google.com'

      meeting = FactoryBot.build(:meeting, video_link: 'http://google.com')
      expect(meeting.video_link_prefixed).to eq 'http://google.com'

      meeting = FactoryBot.build(:meeting, agenda_link: 'https://google.com')
      expect(meeting.agenda_link_prefixed).to eq 'https://google.com'
    end
  end
end
