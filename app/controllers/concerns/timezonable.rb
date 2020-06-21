module Timezonable
  def offset_for_timezone(timezone)
    ActiveSupport::TimeZone[timezone].formatted_offset
  end

  def set_timezone(datetime, timezone)
    datetime.change(offset: offset_for_timezone(timezone))
  end

  def strip_timezone(datetime, timezone)
    datetime.in_time_zone(timezone).to_datetime.change(offset: 0)
  end
end
