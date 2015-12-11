require 'representable/json'

module MapRepresenter
  include Representable::JSON

  property :id
  property :summary_polyline
  property :resource_state
end
