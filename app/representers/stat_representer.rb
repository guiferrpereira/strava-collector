require 'representable/json'

module StatRepresenter
  include Representable::JSON

  property :current, decorator: TotalRepresenter, class: Stat
  property :year, decorator: TotalRepresenter, class: Stat
  property :all, decorator: TotalRepresenter, class: Stat
end
