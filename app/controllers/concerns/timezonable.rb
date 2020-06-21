module Timezonable
  include ActiveSupport

  def offset_for_timezone(timezone)
    TimeZone.new(timezone).formatted_offset
  end

  def tzinfo_id_for_timezone(timezone)
    TimeZone.find_tzinfo(timezone).identifier
  end

  def set_timezone(datetime, timezone)
    datetime.change(offset: offset_for_timezone(timezone))
  end

  def convert_and_strip_timezone(datetime, timezone)
    datetime.in_time_zone(timezone).to_datetime.change(offset: 0)
  end
end
