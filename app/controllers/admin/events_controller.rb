class Admin::EventsController < ApplicationController
  before_action :authenticate_admin!,except: [:top]

  def index
    @events = Event.all
  end

end
