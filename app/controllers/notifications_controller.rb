class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications
  end

  def update
    notification=Notification.find(params[:id]) #...①
    if notification.update(checked: true) #...②
      redirect_to action: :index
    end
  end
end
