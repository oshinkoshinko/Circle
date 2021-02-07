class Public::PostRequestsController < ApplicationController

  #自分へのリクエスト一覧画面
  def waiting
    #自分の投稿データを取得
    @posts = Post.where(member_id: current_member.id)
    #自分の投稿データのなかでリクエストされたものを取得
    @requested_posts = PostRequest.where(post_id: @posts.ids)
  end

  def create
    @post = Post.find(params[:post_id])
    @post_request = current_member.post_requests.new(post_id: @post.id)
    @post_request.is_requested = true
    #binding.pry
    @post_request.save
    redirect_to request.referer
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post_request = current_member.post_requests.find_by(post_id: @post.id)
    @post_request.destroy
    #@post_request.is_requested = false
    redirect_to request.referer
  end

end
