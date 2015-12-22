require 'representable/json'

module AthleteRepresenter
  include Representable::JSON

  property :id
  property :resource_state
  property :firstname
  property :lastname
  property :profile_medium
  property :profile
  property :city
  property :state
  property :country
  property :sex
  property :friend
  property :follower
  property :premium
  property :created_at
  property :updated_at
  property :approve_followers
  property :follower_count
  property :friend_count
  property :mutual_friend_count
  property :date_preference
  property :measurement_preference
  property :email
  property :ftp
  property :clubs
  property :bikes
  property :shoes

  property :activities
  property :access_token
  property :stats
end
