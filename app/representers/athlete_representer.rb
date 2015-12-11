require 'representable/json'

module AthleteRepresenter
  include Representable::JSON

  property :id
  property :resource_state
end
