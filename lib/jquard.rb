require "view_component"
require "turbo-rails"

require "jquard/version"
require "jquard/engine"
require "jquard/configuration"
require "jquard/component_dispatch"
require "jquard/registry"
require "jquard/resource"
require "jquard/resources/pages/page"
require "jquard/resources/pages/list_records"
require "jquard/resources/pages/create_record"
require "jquard/resources/pages/edit_record"
require "jquard/icons"
require "jquard/tables/columns/column"
require "jquard/tables/columns/text_column"
require "jquard/tables/columns/icon_column"
require "jquard/tables/actions/action"
require "jquard/tables/actions/edit_action"
require "jquard/tables/actions/delete_action"
require "jquard/tables/table"
require "jquard/tables/components"
require "jquard/tables/query"
require "jquard/schemas/schema"
require "jquard/schemas/fields/field"
require "jquard/schemas/fields/text_input"
require "jquard/schemas/fields/textarea"
require "jquard/schemas/fields/select"
require "jquard/schemas/fields/checkbox"
require "jquard/schemas/fields/toggle"
require "jquard/schemas/fields/date_picker"
require "jquard/schemas/fields/date_time_picker"
require "jquard/schemas/fields/hidden"
require "jquard/schemas/layouts/layout"
require "jquard/schemas/layouts/section"
require "jquard/schemas/layouts/grid"
require "jquard/schemas/components"

module Jquard
  class Error < StandardError; end

  class << self
    def config
      @config ||= Configuration.new
    end

    def configure
      yield config
    end

    def registry
      @registry ||= Registry.new
    end

    def eager_load_resources!
      dir = resources_dir
      Rails.autoloaders.main.eager_load_dir(dir) if dir&.directory?
    end

    def resources_dir
      return nil unless defined?(Rails.application) && Rails.application

      Rails.application.root.join("app/jquard")
    end
  end
end
