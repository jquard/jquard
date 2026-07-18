module Jquard
  class ApplicationController < ActionController::Base
    before_action :authenticate_jquard_user!

    private

    def authenticate_jquard_user!
      auth = Jquard.config.authenticate
      instance_exec(&auth) if auth
    end
  end
end
