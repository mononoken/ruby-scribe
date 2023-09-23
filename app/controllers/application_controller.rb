class ApplicationController < ActionController::Base
  # Use Devise to verify all actions authenticate user
  before_action :authenticate_user!

  # Use Action Policy to verify all actions require authorization
  verify_authorized
end
