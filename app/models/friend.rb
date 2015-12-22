class Friend < OpenStruct
  def self.all athlete_id=nil
    @all ||= Redis.new.keys("friend-#{athlete_id}-*").map do |key|
      self.new.extend(AthleteRepresenter).from_json(Redis.new.get(key))
    end.compact
  end

  def stats
    Stat.find(self.id)
  end

  def converted_time
    minutes = convert_time_to_minutes % 60
    hours = convert_time_to_minutes / 60

    format("%03d:%02d:00", hours, minutes) #=> "001:00:00"
  end

  def convert_time_to_minutes
    (convert_read_format.first.to_i * 60) + convert_read_format.last.to_i
  end

  def convert_read_format
    self.stats.year.time.gsub("m", "").split("h ")
  end
end
