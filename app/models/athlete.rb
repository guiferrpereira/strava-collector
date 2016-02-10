class Athlete < OpenStruct
  attr_accessor :athlete_json

  def self.all
    @all ||= Redis.new.keys("athlete-*").map do |key|
      self.new.extend(AthleteRepresenter).from_json(parse_json(Redis.new.get(key)).to_json)
    end.compact
  end

  def self.find_or_create athlete_json
    @athlete_json = athlete_json

    athlete = self.new.extend(AthleteRepresenter).from_json(parse_json(@athlete_json).to_json)

    create_or_update(athlete_json)

    athlete
  end

  def self.find id
    self.new.extend(AthleteRepresenter).from_json(parse_json(read(id)).to_json)
  end

  def access_token
    JSON.parse(Redis.new.get("athlete-#{self.id}"))["access_token"]
  end

  def activities
    Activity.all(self.id)
  end

  def friends
    Friend.all(self.id)
  end

  def followers
    Follower.all(self.id)
  end

  private
  def self.read id
    Redis.new.get("athlete-#{id}")
  end

  def self.create_or_update athlete_json
    Redis.new.set("athlete-#{parse_json(athlete_json)['id']}", athlete_json)
  end

  def self.parse_json athlete_json
    JSON.parse(athlete_json)["athlete"]
  end
end
