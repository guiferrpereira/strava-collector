class Athlete < OpenStruct
  def self.find_or_create json
    athlete = self.new.extend(AthleteRepresenter).from_json(json)

    create(json) if read(athlete.id).nil?
  end

  private
  def self.read id
    Redis.new.get("athlete-#{id}")
  end

  def self.create athlete_json
    Redis.new.set("athlete-#{athlete_json['athlete']['id']}", athlete_json)
  end
end
