require "view_component"
require "turbo-rails"

require "jquard/version"
require "jquard/engine"
require "jquard/configuration"
require "jquard/registry"
require "jquard/resource"
require "jquard/icons"
require "jquard/tables/columns/column"
require "jquard/tables/columns/text_column"
require "jquard/tables/columns/icon_column"
require "jquard/tables/table"
require "jquard/tables/components"
require "jquard/tables/query"

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
