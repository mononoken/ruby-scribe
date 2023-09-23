class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: %i[splash]
  skip_verify_authorized only: %i[splash]

  def splash
  end
end
