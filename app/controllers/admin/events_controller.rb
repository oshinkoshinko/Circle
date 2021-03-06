class Admin::EventsController < ApplicationController
  before_action :authenticate_admin!,except: [:top]

  def index
    @events = Event.all.order("started_at ASC").includes(:member, :genre, :event_members)
  end

end
