class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: %i[splash]

  def splash
  end
end
