class Meeting < ApplicationRecord
  belongs_to :police_district

  def formatted_event_datetime
    event_datetime&.in_time_zone(police_district.timezone)&.strftime('%b %e, %Y @ %l:%M%P')
  end
end
