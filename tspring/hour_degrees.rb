
class HourDegrees
  DEGREES_PER_MIN = 6
  DEGREES_PER_HOUR = 30

  def self.time_degrees(hour, min)
    (minute_degrees(min) - hour_degrees(hour, min)).abs
  end

  def self.minute_degrees(min)
    minute_degrees = min * DEGREES_PER_MIN
  end

  def self.hour_degrees(hour, min)
    hour_hand_position = hour % 12
    hour_degrees = hour_hand_position * DEGREES_PER_HOUR
    incremental_position = min / 60.0
    hour_degrees + (DEGREES_PER_HOUR * incremental_position)
  end
end
