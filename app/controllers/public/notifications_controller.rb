class Public::NotificationsController < ApplicationController
  before_action :authenticate_member!,except: [:top]

  def index
    @notifications = current_member.passive_notifications.page(params[:page]).per(20)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy_all
    #通知を全削除
      @notifications = current_member.passive_notifications.destroy_all
      redirect_to notifications_path
  end

end
