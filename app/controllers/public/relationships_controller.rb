class Public::RelationshipsController < ApplicationController
  before_action :authenticate_member!,except: [:top]

  def create
    #ajax用に@member追加 paramsで送られてきたのはmember_id
    @member = Member.find(params[:member_id])
    current_member.follow(params[:member_id])
    #通知機能↓
    @member.create_notification_follow!(current_member)

  end

  def destroy
    @member = Member.find(params[:member_id])
    current_member.unfollow(params[:member_id])
  end

  def follow
    @member = Member.find(params[:member_id])
    @members = @member.following_member
  end

  def unfollow
    @member = Member.find(params[:member_id])
    @members = @member.follower_member
  end
end
