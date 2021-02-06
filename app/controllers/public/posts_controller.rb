class Public::PostsController < ApplicationController

 def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    #binding.pry
    @post.save
    redirect_to request.referer
 end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:body, :genre_id, :member_id)
  end

end
