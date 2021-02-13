class Public::PostCommentsController < ApplicationController
  before_action :authenticate_member!,except: [:top]

  def show
   @post = Post.find(params[:id])
   @post_comment = PostComment.new
   #コメント一覧表示用インスタンス
   @post_comments = PostComment.where(post_id: params[:id])
   #binding.pry
  end

  def create

    @post_comment = PostComment.new(post_comment_params)
    @post_comment.member_id = current_member.id
    @post_comment.save

    #通知機能↓
    @post = @post_comment.post
    @post.create_notification_comment!(current_member, @post_comment.id)

    #redirect_to request.referer
    #非同期通信
    @post_comments = PostComment.where(post_id: @post_comment.post)

  end

  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    @post_comments = PostComment.where(post_id: @post_comment.post)
    #binding.pry
    #redirect_to request.referer

  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :member_id, :post_id)
  end

end
