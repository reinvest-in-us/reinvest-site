# Documentation https://github.com/InteractionDesignFoundation/add-event-to-calendar-docs/blob/master/services/google.md
class GoogleCalendar
  include Timezonable

  include Rails.application.routes.url_helpers
  delegate :default_url_options, :url_options, to: :@context

  BASE_URL = 'https://www.google.com/calendar/render'

  # A map of Rails timezone strings we support to Python, which Google
  #   Calendar supports
  TIMEZONE_LOOKUP = {
    'Pacific Time (US & Canada)' => 'US/Pacific',
  }.freeze

  def initialize(context)
    @context = context # needs controller context for route helper
  end

  def generate_event_link(district, meeting)
    BASE_URL + "?" + {
      action: 'TEMPLATE',
      dates: formatted_time(meeting.event_datetime, district.timezone),
      text: district.name + ' Policing Budget Meeting',
      location: 'Virtual [details in description]',
      details: formatted_details(district, meeting),
      ctz: tzinfo_id_for_timezone(district.timezone)
    }.to_query
  end

  private

  def formatted_time(date, timezone)
    # Set in local time, but strip timezone. Will display in time local to browser
    format = '%Y%m%d' + 'T' + '%H%M%S'

    adjusted_time = convert_and_strip_timezone(date, timezone)
    adjusted_time.strftime(format) + "/" + (adjusted_time + 1.hour).strftime(format)
  end

  def formatted_details(district, meeting)
    <<~STRING
      #{"Agenda link:\n#{meeting.agenda_link}\n" if meeting.agenda_link.present?}
      #{"Call-in at:\n#{meeting.phone_number}\n" if meeting.phone_number.present?}
      #{"Watch at:\n#{meeting.video_link}\n" if meeting.video_link.present?}
      #{"How to comment:\n#{meeting.how_to_comment}\n" if meeting.how_to_comment.present?}
      For more information, visit #{police_district_url(district)}
    STRING
  end
end
