class Public::PostRequestsController < ApplicationController
  before_action :authenticate_member!,except: [:top]

  #自分へのリクエスト一覧画面
  def waiting
    #自分の投稿データを取得
    @posts = Post.where(member_id: current_member.id).includes(:member)
    #自分の投稿データのなかでリクエストされたものを取得
    @requested_posts = PostRequest.where(post_id: @posts.ids, is_accepted: false).order("created_at DESC").includes(:post, :member)
    @accept_posts = PostRequest.where(post_id: @posts.ids, is_accepted: true).order("created_at DESC").includes(:post, :member)
    #リクエストした投稿データを取得
    @requesting_posts = PostRequest.where(member_id: current_member.id).order("created_at DESC").includes(:post, :member)
  end

  def create
    @post = Post.find(params[:post_id])
    @post_request = current_member.post_requests.new(post_id: @post.id)
    @post_request.is_requested = true
    @post_request.save
    #通知機能↓
    @post.create_notification_request!(current_member)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post_request = current_member.post_requests.find_by(post_id: @post.id)
    @post_request.destroy

    #非同期通信js用変数
    @requesting_posts = PostRequest.where(member_id: current_member.id).order("created_at DESC")
  end

  def update
    @post_request = PostRequest.find(params[:id])
    @post_request.update(is_accepted: params[:is_accepted], is_requested: params[:is_requested])

    CreateNotification.call(
    contents: { 'en' => 'Request accepted', 'ja' => 'リクエストが承認されました！' },
    type: 'post_requests#update'
    )

    #非同期通信js用変数
    #自分の投稿データを取得
    @posts = Post.where(member_id: current_member.id)
    #自分の投稿データのなかでリクエストされたものを取得
    @requested_posts = PostRequest.where(post_id: @posts.ids, is_accepted: false).order("created_at DESC")
    @accept_posts = PostRequest.where(post_id: @posts.ids, is_accepted: true).order("created_at DESC")
  end

end
