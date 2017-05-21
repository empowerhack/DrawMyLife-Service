module Representer
  module Routing
    extend ActiveSupport::Concern
    include Rails.application.routes.url_helpers

    included do
      def default_url_options
        Rails.application.config.action_controller.default_url_options
      end
    end
  end
end
