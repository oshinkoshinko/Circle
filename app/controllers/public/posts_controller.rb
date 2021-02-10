class Public::PostsController < ApplicationController

 def index
    #@posts = Post.all.order("created_at DESC") ransackで定義済み
    #検索窓用変数定義
    @q = Post.ransack(params[:q])
    @genres = Genre.all
    @posts = @q.result(distinct: true).order("created_at DESC")
 end

 def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    @post.save
    redirect_to request.referer
 end

  def edit
    @post = Post.find(params[:id])
    @genres = Genre.all
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to member_path
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to request.referer
  end

  private

  def post_params
    params.require(:post).permit(:body, :genre_id, :member_id)
  end

  def search_params
    params.require(:q).permit!
  end

end
