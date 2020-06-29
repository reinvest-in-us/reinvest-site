class Meeting < ApplicationRecord
  include LinkPrefixHelper

  MEETING_WAIT_PERIOD = 8.hours

  belongs_to :police_district

  scope :upcoming_and_ongoing, -> {
    where('event_datetime > ?', Time.current.utc - MEETING_WAIT_PERIOD).order(event_datetime: :asc)
  }
  scope :past, -> {
    where('event_datetime <= ?', Time.current.utc - MEETING_WAIT_PERIOD).order(event_datetime: :desc)
  }

  def formatted_event_datetime
    if event_datetime == nil
      nil
    else
      day_diff = (event_datetime&.in_time_zone(police_district.timezone).midnight - DateTime.now.in_time_zone(police_district.timezone).midnight).to_i / 86400
      time_format = '%l:%M%P %Z'

      if day_diff == 0
        event_datetime&.in_time_zone(police_district.timezone)&.strftime('Today, ' + time_format)
      elsif day_diff >= 0 && day_diff <= 6
        event_datetime&.in_time_zone(police_district.timezone)&.strftime('%A, ' + time_format)
      else
        event_datetime&.in_time_zone(police_district.timezone)&.strftime('%b %-d, ' + time_format)
      end
    end
  end

  def agenda_link_prefixed
    prefix(agenda_link)
  end

  def video_link_prefixed
    prefix(video_link)
  end
end
