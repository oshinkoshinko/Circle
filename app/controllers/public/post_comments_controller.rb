class Public::PostCommentsController < ApplicationController

  def show
   @post = Post.find(params[:id])
   @post_comment = PostComment.new
   #コメント一覧表示用インスタンス
   @post_comments = PostComment.where(post_id: params[:id])
  end

  def create
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.member_id = current_member.id
    @post_comment.save
    redirect_to request.referer
  end

  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    redirect_to request.referer
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :member_id, :post_id)
  end

end
