class Public::PostCommentsController < ApplicationController

  def show
   @post = Post.find(params[:id])
   @post_comment = PostComment.new
   @post_comments = PostComment.where(post_id: params[:id])
  end

  def create
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.member_id = current_member.id
    #binding.pry
    @post_comment.save
    redirect_to request.referer
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :member_id, :post_id)
  end

end
