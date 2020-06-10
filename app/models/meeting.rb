class Meeting < ApplicationRecord
  belongs_to :police_district

  def formatted_event_datetime
    event_datetime&.strftime('%b %e, %Y @%l:%M%P')
  end
end
