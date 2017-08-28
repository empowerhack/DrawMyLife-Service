require 'concerns/routing'

class BaseRepresenter < Roar::Decorator
  include Roar::JSON::HAL
  include Representer::Routing
end
