require 'rails_helper'

RSpec.describe Meeting, type: :model do
  describe '.formatted_event_datetime' do
    it 'returns the formatted string' do
      meeting = FactoryBot.build(:meeting, event_datetime: DateTime.new(2010,10,20,13,30,00))
      expect(meeting.formatted_event_datetime).to eq('Oct 20, 2010 @ 1:30pm')
    end

    context 'when event_datetime is nil' do
      it 'returns nil' do
        meeting = FactoryBot.build(:meeting, event_datetime: nil)
        expect(meeting.formatted_event_datetime).to be_nil
      end
    end
  end
end
