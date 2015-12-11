require 'representable/json'

module ActivityRepresenter
  include Representable::JSON

  property :id
  property :external_id
  property :upload_id
  property :name
  property :resource_state
  property :distance
  property :moving_time
  property :elapsed_time
  property :total_elevation_gain
  property :type
  property :start_date
  property :start_date_local
  property :timezone
  property :start_latlng
  property :end_latlng
  property :location_city
  property :location_state
  property :location_country
  property :start_latitude
  property :start_longitude
  property :achievement_count
  property :kudos_count
  property :comment_count
  property :athlete_count
  property :photo_count
  property :trainer
  property :commute
  property :manual
  property :private
  property :flagged
  property :gear_id
  property :average_speed
  property :max_speed
  property :average_watts
  property :kilojoules
  property :device_watts
  property :total_photo_count
  property :has_kudoed
  property :workout_type

  property :athlete, extend: AthleteRepresenter, class: Athlete
  property :map, extend: MapRepresenter, class: Map
end



