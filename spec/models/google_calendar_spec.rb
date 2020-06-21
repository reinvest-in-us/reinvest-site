require 'rails_helper'

RSpec.describe GoogleCalendar do
  describe '.generate_event_link' do
    let(:district) do
      FactoryBot.build(:police_district,
                       slug: 'san-francisco',
                       name: 'San Francisco',
                       timezone: 'Pacific Time (US & Canada)')
    end

    let(:meeting) do
      FactoryBot.build(:meeting,
                       agenda_link: 'https://example.com/agenda',
                       phone_number: '555-419-5555',
                       video_link: 'https://example.com/watch',
                       how_to_comment: 'comment this way',
                       event_datetime: DateTime.new(2025,7,20,21,30,00, 0)) # 7/20/2020 @ 2:30pm Pacific
    end

    let(:controller_context) do
      # Needed to use police district path helper
      double('fake controller context', url_options: { host: 'example.com' }, default_url_options: { host: 'example2.com' })
    end

    it 'creates a URL with proper prefix' do
      travel_to Date.parse('2020-06-03') do
        url = GoogleCalendar.new(controller_context).generate_event_link(district, meeting)
        expect(url).to start_with('https://www.google.com/calendar/render?action=TEMPLATE')
      end
    end

    it 'includes call-in information in description' do
      travel_to Date.parse('2020-06-03') do
        url = GoogleCalendar.new(controller_context).generate_event_link(district, meeting)

        parsed_url = URI.parse(url)
        parsed_query = CGI.parse(parsed_url.query)

        expect(parsed_query['details'].first).to include('https://example.com/agenda')
        expect(parsed_query['details'].first).to include('https://example.com/watch')
        expect(parsed_query['details'].first).to include('555-419-5555')
        expect(parsed_query['details'].first).to include('comment this way')
      end
    end

    it 'includes a link to the district information page in description' do
      travel_to Date.parse('2020-06-03') do
        url = GoogleCalendar.new(controller_context).generate_event_link(district, meeting)

        parsed_url = URI.parse(url)
        parsed_query = CGI.parse(parsed_url.query)

        expect(parsed_query['details'].first).to include('http://example.com/d/san-francisco')
      end
    end

    it 'sets the event location' do
      travel_to Date.parse('2020-06-03') do
        url = GoogleCalendar.new(controller_context).generate_event_link(district, meeting)

        parsed_url = URI.parse(url)
        parsed_query = CGI.parse(parsed_url.query)

        expect(parsed_query['location'].first).to eq('Virtual [details in description]')
      end
    end

    it 'sets the event title' do
      travel_to Date.parse('2020-06-03') do
        url = GoogleCalendar.new(controller_context).generate_event_link(district, meeting)

        parsed_url = URI.parse(url)
        parsed_query = CGI.parse(parsed_url.query)

        expect(parsed_query['text'].first).to eq('San Francisco Policing Budget Meeting')
      end
    end

    it "sets start time in the district's timezone, and passes the timezone" do
      travel_to Date.parse('2020-06-03') do
        url = GoogleCalendar.new(controller_context).generate_event_link(district, meeting)

        parsed_url = URI.parse(url)
        parsed_query = CGI.parse(parsed_url.query)

        start_date, end_date = parsed_query['dates'].first.split('/')
        expect(start_date).to eq('20250720' + 'T' + '143000')
        expect(end_date).to eq('20250720' + 'T' + '153000')

        expect(parsed_query['ctz'].first).to eq('America/Los_Angeles')
      end
    end
  end

  describe 'TIMEZONE_LOOKUP' do
    it "has an entry for each valid PoliceDistrict timezone, so we don't leave any out accidentally" do
      expect(GoogleCalendar::TIMEZONE_LOOKUP.keys).to match_array(PoliceDistrict::TIME_ZONE_OPTIONS)
    end
  end
end
