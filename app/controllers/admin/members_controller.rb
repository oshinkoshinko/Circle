class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!,except: [:top]

  def index
    @members = Member.all
    @active_members = Member.where(is_deleted: false)
  end

end
