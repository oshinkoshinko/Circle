class Public::EventsController < ApplicationController
  before_action :authenticate_member!,except: [:top]
  before_action :correct_member, only: [:edit, :update, :destroy]

  def index
    #検索値を取得
    @q = Event.ransack(params[:q])
    #ジャンル検索用変数
    @genres = Genre.all
    #イベント取得(開催中ステータス)
    @new_events = @q.result(distinct: true).order("started_at ASC").includes(:member)
    #開催済みイベント取得
    @finished_events = @q.result(distinct: true).order("finished_at DESC").includes(:member)
  end

  def new
    @event = Event.new
    @genres = Genre.all
  end

  def create
    @event = Event.new(event_params)
    @event.member_id = current_member.id
    if @event.save
      redirect_to events_myevent_path
    else
      @genres = Genre.all
      render :new
    end

  end

  def edit
    @event = Event.find(params[:id])
    @genres = Genre.all
    #申し込みがあってから参加費の変更を無効にする条件分岐
    @event_members = @event.event_members
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to events_myevent_path
    else
      @genres = Genre.all
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_myevent_path
  end

  def show
    @event = Event.find(params[:id])
    @event_members = @event.event_members
    #イベント参加キャンセル用変数
    @event_member = EventMember.find_by(event_id: @event.id, member_id: current_member.id)
  end

  def myevent
    #参加イベント取得
    @join_events = EventMember.where(member_id: current_member.id).includes(:event)
    #ログインユーザの開催予定イベント取得
    @active_events = Event.where(member_id: current_member.id).order("started_at ASC")
    #ログインユーザの開催済みイベント取得
    @finished_events = Event.where(member_id: current_member.id).order("finished_at DESC")
  end

  def correct_member
    @event = Event.find(params[:id])
    @member = Member.find_by(id: @event.member.id)
    if @member != current_member
    redirect_to root_path
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :name,
      :content,
      :place,
      :event_image,
      :fee,
      :is_finished,
      :started_at,
      :finished_at,
      :expired_at,
      :member_id,
      :genre_id)
  end

  def search_params
    params.require(:q).permit!
  end

end
