class Admin::MembersController < ApplicationController

  def index
    @members = Member.all
    @active_members = Member.where(is_deleted: false)
  end

end
