class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: %i[splash about]
  skip_verify_authorized only: %i[splash about]

  def splash
  end

  def about
  end
end
