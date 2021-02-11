class Public::EventsController < ApplicationController

  def index
    #検索値を取得
    @q = Event.ransack(params[:q])
    #ジャンル検索用変数
    @genres = Genre.all
    #イベント取得(開催中ステータス)
    @new_events = @q.result(distinct: true).where(is_finished: false).order("started_at ASC")
    #開催済みイベント取得
    @finished_events = Event.where(is_finished: true).order("finished_at DESC")

  end

  def new
    @event = Event.new
    @genres = Genre.all
  end

  def create
    @event = Event.new(event_params)
    @event.member_id = current_member.id
    @event.save
    redirect_to events_myevent_path
  end

  def edit
    @event = Event.find(params[:id])
    @genres = Genre.all
    #申し込みがあってから参加費の変更を無効にする条件分岐
    @event_members = EventMember.where(event_id: @event.id)
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    redirect_to events_myevent_path
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_myevent_path
  end

  def show
    @event = Event.find(params[:id])
    @event_members = EventMember.where(event_id: @event.id)
    #イベント参加キャンセル用変数
    @event_member = EventMember.find_by(event_id: @event.id, member_id: current_member.id)
  end

  def myevent
    #参加予定イベント取得
    @join_events = EventMember.where(member_id: current_member.id)
    #ログインユーザの開催予定イベント取得
    @active_events = Event.where(member_id: current_member.id, is_finished: false).order("started_at ASC")
    #ログインユーザの開催済みイベント取得
    @finished_events = Event.where(member_id: current_member.id, is_finished: true).order("finished_at DESC")
  end

  private

  def event_params
    params.require(:event).permit(
      :name,
      :content,
      :place,
      :event_image_id,
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
