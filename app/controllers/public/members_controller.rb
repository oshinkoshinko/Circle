class Public::MembersController < ApplicationController

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    @member.update(member_params)
    redirect_to member_path(@member.id)
  end

  def unsubscribe
  end

  def withdraw
  end

  def member_params
    params.require(:member).permit(:name, :account_name, :profile_image, :introduction)
  end

end
