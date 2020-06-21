# For use in controllers only
module GoogleCalendarable
  extend ActiveSupport::Concern

  included do
    helper_method :google_calendar_link

    def google_calendar_link
      return unless @district.next_meeting

      GoogleCalendar.new(self).generate_event_link(@district, @district.next_meeting)
    end
  end
end