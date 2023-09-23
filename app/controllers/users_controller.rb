class UsersController < ApplicationController
  skip_verify_authorized only: %i[show]

  def show
  end
end
