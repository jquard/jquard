require "bundler/setup"

APP_RAKEFILE = File.expand_path("test/dummy/Rakefile", __dir__)
load "rails/tasks/engine.rake"

require "bundler/gem_tasks"

namespace :jquard do
  namespace :css do
    input = File.expand_path("lib/jquard/tailwind/application.css", __dir__)
    output = File.expand_path("app/assets/stylesheets/jquard/application.css", __dir__)

    desc "Compile the engine stylesheet"
    task :build do
      sh "tailwindcss", "-i", input, "-o", output, "--minify"
    end

    desc "Recompile the engine stylesheet on change"
    task :watch do
      sh "tailwindcss", "-i", input, "-o", output, "--watch"
    end
  end
end
