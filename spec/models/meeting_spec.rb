require 'rails_helper'

RSpec.describe Meeting, type: :model do
  describe 'factories' do
    it 'builds valid factories' do
      expect(FactoryBot.build(:meeting)).to be_valid
    end
  end

  describe '.formatted_event_datetime' do
    it 'returns the formatted string in the district timezone' do
      meeting = FactoryBot.build(:meeting, event_datetime: DateTime.new(2010,10,20,13,30,00))
      expect(meeting.formatted_event_datetime).to include('Oct 20, 2010 @ ')
      expect(meeting.formatted_event_datetime).to include('6:30am')
    end

    context 'when event_datetime is nil' do
      it 'returns nil' do
        meeting = FactoryBot.build(:meeting, event_datetime: nil)
        expect(meeting.formatted_event_datetime).to be_nil
      end
    end
  end
end
