class FollowerStat < OpenStruct
  def self.find athlete_id
    self.new.extend(StatRepresenter).from_json(Redis.new.get("stats-#{athlete_id}-follower"))
  end
end
