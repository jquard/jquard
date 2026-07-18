require "rails/generators"

module Jquard
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      class_option :path, type: :string, default: "admin",
        desc: "Mount path for the admin panel"

      def add_mount_route
        route %(mount Jquard::Engine => "/#{options[:path]}")
      end

      def create_initializer
        template "initializer.rb.tt", "config/initializers/jquard.rb"
      end

      def show_next_steps
        say ""
        say "Jquard is mounted at /#{options[:path]}.", :green
        say ""
        say "Next: configure authentication in config/initializers/jquard.rb —", :yellow
        say "the panel refuses to serve until you do.", :yellow
        say ""
        say "Then generate your first resource with:", :green
        say ""
        say "  bin/rails generate jquard:resource YourModel", :bold
        say ""
      end
    end
  end
end
