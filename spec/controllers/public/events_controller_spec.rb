require 'rails_helper'

RSpec.describe Public::EventsController, type: :controller do
  before do
    @genre = create(:genre)
    @member = FactoryBot.create(:member)
    @event = FactoryBot.create(:event, {member: @member, genre: @genre})
  end

  describe "#index" do
    context "認証済みのユーザーとして" do
      it "正常なレスポンスか" do
        sign_in @member
        get :index
        expect(response).to be_success
      end
      it "200レスポンスが返ってきているか" do
        sign_in @member
        get :index
        expect(response).to have_http_status "200"
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        get :index
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        get :index
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
  describe "#new" do
    context "認証済みのユーザーとして" do
      it "正常なレスポンスか" do
        sign_in @member
        get :new
        expect(response).to be_success
      end
      it "200レスポンスが返ってきているか" do
        sign_in @member
        get :new
        expect(response).to have_http_status "200"
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        get :new
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        get :new
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
  describe "#create" do
    context "認証済みのユーザーとして" do
      it "イベント作成できるか" do
        sign_in @member
        expect {
          post :create, params: {
            event: {
              name: "チーム開発",
              content: "チームでECサイトを作ろう！",
              place: "新宿",
              fee: "100",
              started_at: "2099-02-27 00:00:00",
              finished_at: "2099-02-28 00:00:00",
              expired_at: "2099-02-27 00:00:00",
              genre_id: 1,
              member_id: 1,
            }
          }
        }.to change(@member.events, :count).by(1)
      end
      it "投稿後にマイページにリダイレクトされているか" do
        sign_in @member
          post :create, params: {
            event: {
              name: "チーム開発",
              content: "チームでECサイトを作ろう！",
              place: "新宿",
              fee: "100",
              started_at: "2099-02-27 00:00:00",
              finished_at: "2099-02-28 00:00:00",
              expired_at: "2099-02-27 00:00:00",
              genre_id: 1,
              member_id: 1,
            }
          }
        expect(response).to(redirect_to(events_myevent_path))
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        post :create
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        post :create
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
  describe "#edit" do
    context "認証済みのユーザーとして" do
      it "正常なレスポンスか" do
        sign_in @member
        get :edit, params: {id: @event.id}
        expect(response).to be_success
      end
      it "200レスポンスが返ってきているか" do
        sign_in @member
        get :edit, params: {id: @event.id}
        expect(response).to have_http_status "200"
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        get :edit, params: {id: @event.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        get :edit, params: {id: @event.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
  describe "#update" do
    context "認証済みのユーザーとして" do
      it "正常に更新できるか" do
        sign_in @member
        event_params = {content: "イベント内容更新しました"}
        patch :update, params: {id: @event.id, event: event_params}
        expect(@event.reload.content).to eq "イベント内容更新しました"
      end
      it "更新後にマイイベントにリダイレクトされているか" do
        sign_in @member
        event_params = {content: "イベント内容更新しました"}
        patch :update, params: {id: @event.id, event: event_params}
        expect(response).to redirect_to events_myevent_path
      end
      it "フォームが空白の時に更新できなくなっているか" do
        sign_in @member
        event_params = {content: ""}
        patch :update, params: {id: @event.id, event: event_params}
        expect(@event.reload.content).to eq "チームでECサイトを作ろう！"
      end
      it "フォームが空白の時に更新できず、再度編集ページにリダイレクトされるか" do
        sign_in @member
        event_params = {content: ""}
        patch :update, params: {id: @event.id, event: event_params}
        expect(response).to render_template(:edit)
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        patch :update, params: {id: @event.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        patch :update, params: {id: @event.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
  describe "#destroy" do
    context "認証済みのユーザーとして" do
      it "正常に投稿を削除できるか" do
        sign_in @member
        expect {
          delete :destroy, {params: {id: @event.id}}
        }.to change(@member.events, :count).by(-1)
      end
      it "削除後に現在のページにリダイレクトされているか" do
        sign_in @member
        delete :destroy, {params: {id: @event.id}}
        expect(response).to(redirect_to(events_myevent_path))
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        delete :destroy, params: {id: @event.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        delete :destroy, params: {id: @event.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
  describe "#myevent" do
    context "認証済みのユーザーとして" do
      it "正常なレスポンスか" do
        sign_in @member
        get :myevent
        expect(response).to be_success
      end
      it "200レスポンスが返ってきているか" do
        sign_in @member
        get :myevent
        expect(response).to have_http_status "200"
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        get :myevent
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        get :myevent
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
end