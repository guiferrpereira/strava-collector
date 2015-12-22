require 'representable/json'

module TotalRepresenter
  include Representable::JSON

  property :distance
  property :time
  property :elevation

  property :sport
  property :activities
end
