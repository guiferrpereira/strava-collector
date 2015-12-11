class Activity < OpenStruct
  def self.all athlete_id=nil
    @all ||= Redis.new.keys.map do |key|
      self.new.extend(ActivityRepresenter).from_json(Redis.new.get(key)) if key.include?("#{athlete_id}-")
    end.compact
  end
end
