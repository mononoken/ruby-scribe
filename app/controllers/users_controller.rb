class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      flash.now[:error] = @user.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:bio)
  end

  def set_user
    @user = User.find(params[:id])

    authorize! @user
  end
end
