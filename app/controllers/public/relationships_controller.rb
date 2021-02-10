class Public::RelationshipsController < ApplicationController
  def create
    #ajax用に@member追加 paramsで送られてきたのはmember_id
    @member = Member.find(params[:member_id])
    current_member.follow(params[:member_id])

    #通知機能↓
    #binding.pry
    @member.create_notification_follow!(current_member)

  end

  def destroy
    @member = Member.find(params[:member_id])
    current_member.unfollow(params[:member_id])
    #redirect_to request.referer
  end

  def follow
    @member = Member.find(params[:member_id])
    @members = @member.following_member
    #binding.pry
  end

  def unfollow
    @member = Member.find(params[:member_id])
    @members = @member.follower_member
  end
end
