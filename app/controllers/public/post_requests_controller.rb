class Public::PostRequestsController < ApplicationController

  def index
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
