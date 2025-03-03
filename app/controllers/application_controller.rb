class ApplicationController < ActionController::Base
  # Devise will require users to sign in for all actions by default.
  # If you want some actions to be publicly accessible, use skip_before_action in those controllers.
  before_action :authenticate_user!
end
