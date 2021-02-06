class Public::PostsController < ApplicationController

 def create
    #binding.pry
    @post = Post.new(post_params)
    @post.member_id = current_member.id
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
    params.require(:post).permit(:body)
  end

end
