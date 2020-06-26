class Meeting < ApplicationRecord
  include LinkPrefixHelper

  belongs_to :police_district

  def formatted_event_datetime
    event_datetime&.in_time_zone(police_district.timezone)&.strftime('%A, %B %e at %l:%M%P')
  end

  def agenda_link_prefixed
    prefix(agenda_link)
  end

  def video_link_prefixed
    prefix(video_link)
  end
end
