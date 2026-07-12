require "jquard/version"
require "jquard/engine"
require "jquard/registry"
require "jquard/resource"

module Jquard
  class Error < StandardError; end

  class << self
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
