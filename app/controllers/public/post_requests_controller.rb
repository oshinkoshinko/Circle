class Public::PostRequestsController < ApplicationController

  #自分へのリクエスト一覧画面
  def waiting
    #自分の投稿データを取得
    @posts = Post.where(member_id: current_member.id)
    #自分の投稿データのなかでリクエストされたものを取得
    @requested_posts = PostRequest.where(post_id: @posts.ids).order("created_at DESC")
    #リクエストした投稿データを取得
    @requesting_posts = PostRequest.where(member_id: current_member.id).order("created_at DESC")
  end

  def create
    @post = Post.find(params[:post_id])
    @post_request = current_member.post_requests.new(post_id: @post.id)
    @post_request.is_requested = true
    @post_request.save
    #通知機能↓
    post.create_notification_like!(current_member)
    respond_to :js

    redirect_to request.referer
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post_request = current_member.post_requests.find_by(post_id: @post.id)
    @post_request.destroy
    #@post_request.is_requested = false
    redirect_to request.referer
  end

  def update
    @post_request = PostRequest.find(params[:id])
    @post_request.update(is_accepted: params[:is_accepted], is_requested: params[:is_requested])
    redirect_to request.referer
  end

end
