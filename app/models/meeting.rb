class Meeting < ApplicationRecord
  include LinkPrefixHelper

  belongs_to :police_district
  validate :datetime_in_future

  def formatted_event_datetime
    event_datetime&.in_time_zone(police_district.timezone)&.strftime('%b %e, %Y @ %l:%M%P')
  end

  def agenda_link_prefixed
    prefix(agenda_link)
  end

  def video_link_prefixed
    prefix(video_link)
  end

  private

  def datetime_in_future
    if event_datetime.present? && event_datetime < Time.current.utc
      errors.add(:event_datetime, 'in past')
    end
  end
end
