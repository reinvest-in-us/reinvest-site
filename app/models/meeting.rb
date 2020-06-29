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
    event_datetime&.in_time_zone(police_district.timezone)&.strftime('%a, %-m/%d at %l:%M%P %Z')
  end

  def agenda_link_prefixed
    prefix(agenda_link)
  end

  def video_link_prefixed
    prefix(video_link)
  end
end
