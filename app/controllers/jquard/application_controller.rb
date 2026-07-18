module Jquard
  class ApplicationController < ActionController::Base
    before_action :authenticate_jquard_user!

    private

    def authenticate_jquard_user!
      auth = Jquard.config.authenticate

      unless auth
        raise Jquard::Error,
          "Jquard refuses to serve the admin panel without authentication. " \
          "Configure config.authenticate_with in a Jquard.configure block, " \
          "or opt into a public panel explicitly with an empty block: authenticate_with { }."
      end

      instance_exec(&auth)
    end
  end
end
