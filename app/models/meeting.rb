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
    if DateTime.now.in_time_zone(police_district.timezone).midnight == event_datetime&.in_time_zone(police_district.timezone).midnight
      event_datetime&.in_time_zone(police_district.timezone)&.strftime('Today, %l:%M%P %Z')
    elsif DateTime.now.in_time_zone(police_district.timezone).advance(:days => 6).midnight >= event_datetime&.in_time_zone(police_district.timezone).midnight
      event_datetime&.in_time_zone(police_district.timezone)&.strftime('%A, %l:%M%P %Z')
    else
      event_datetime&.in_time_zone(police_district.timezone)&.strftime('%b %-m, %l:%M%P %Z')
    end
  end

  def agenda_link_prefixed
    prefix(agenda_link)
  end

  def video_link_prefixed
    prefix(video_link)
  end
end
