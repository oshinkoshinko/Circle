class Public::PostsController < ApplicationController
  before_action :authenticate_member!,except: [:top]
  before_action :correct_member, only: [:edit, :update, :destroy]

 def index
    #検索窓用変数定義
    @q = Post.ransack(params[:q])
    @genres = Genre.all
    #24時間以内の投稿のみ表示
    @posts = @q.result(distinct: true).order("created_at DESC").where(created_at: 24.hours.ago..Time.now)
 end

 def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    @post.save
    #redirect_to request.referer
    redirect_to member_path(current_member)
    #非同期通信
    #@posts = Post.where(member_id: current_member.id).order("created_at DESC")
 end

  def edit
    @post = Post.find(params[:id])
    @genres = Genre.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to member_path(current_member.id)
    else
      @genres = Genre.all
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    if request.referer != nil
      redirect_to request.referer
    else
      redirect_to member_path(current_member)
    end
    #非同期通信
    # @posts = Post.where(member_id: current_member.id).order("created_at DESC")
  end

  def correct_member
    @post = Post.find(params[:id])
    @member = Member.find_by(id: @post.member.id)
    if @member != current_member
    redirect_to root_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :address, :latitude, :longitude, :genre_id, :member_id)
  end

  def search_params
    params.require(:q).permit!
  end

end
