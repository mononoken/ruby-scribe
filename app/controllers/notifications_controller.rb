class NotificationsController < ApplicationController
  before_action :set_notification, only: %i[destroy]

  def index
    @notifications = Notification.where(recipient: current_user)
    authorize! @notifications
  end

  def destroy
    @notification.destroy
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])

    authorize! @notification
  end
end
