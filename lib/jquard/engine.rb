module Jquard
  class Engine < ::Rails::Engine
    isolate_namespace Jquard

    # app/jquard holds Jquard-namespaced classes, so it must be taken away
    # from the default autoload roots and re-registered with a namespace.
    # It is no longer an autoload path afterwards, so the dev file watcher
    # has to be pointed at it explicitly.
    initializer "jquard.autoloading" do |app|
      dir = app.root.join("app/jquard").to_s
      next unless File.directory?(dir)

      ActiveSupport::Dependencies.autoload_paths.delete(dir)
      Rails.autoloaders.main.push_dir(dir, namespace: Jquard)
      app.config.watchable_dirs[dir] = [ :rb ]
    end

    config.to_prepare do
      Jquard.registry.clear
      Jquard.eager_load_resources!
    end
  end
end
