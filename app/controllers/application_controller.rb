class ApplicationController < ActionController::Base
  ForbiddenError = Class.new(StandardError)

  before_action :authenticate_user!
end
