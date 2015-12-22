class Activity < OpenStruct
  def average_speed_converted
    (self.average_speed / 1000) * 3600
  end

  def self.all athlete_id=nil
    @all ||= Redis.new.keys("activity-#{athlete_id}-*").map do |key|
      self.new.extend(ActivityRepresenter).from_json(Redis.new.get(key))
    end.compact
  end
end
