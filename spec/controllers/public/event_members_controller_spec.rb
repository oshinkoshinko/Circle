require 'rails_helper'

RSpec.describe Public::EventMembersController, type: :controller do
  before do
    @genre = create(:genre)
    @member = FactoryBot.create(:member)
    @event = FactoryBot.create(:event, {member: @member, genre: @genre})
    @event_member = FactoryBot.create(:event_member, {member: @member, event: @event})
  end

  describe "#new" do
    context "認証済みのユーザーとして" do
      it "正常なレスポンスか" do
        sign_in @member
        get :new, params: {event_id: @event.id}
        expect(response).to be_success
      end
      it "200レスポンスが返ってきているか" do
        sign_in @member
        get :new, params: {event_id: @event.id}
        expect(response).to have_http_status "200"
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        get :new, params: {event_id: @event.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        get :new, params: {event_id: @event.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
  describe "#show" do
    context "認証済みのユーザーとして" do
      it "正常なレスポンスか" do
        sign_in @member
        get :show, params: {event_id: @event.id, id: @event_member.id}
        expect(response).to be_success
      end
      it "200レスポンスが返ってきているか" do
        sign_in @member
        get :show, params: {event_id: @event.id, id: @event_member.id}
        expect(response).to have_http_status "200"
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        get :show, params: {event_id: @event.id, id: @event_member.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        get :show, params: {event_id: @event.id, id: @event_member.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
  describe "#complete" do
    context "認証済みのユーザーとして" do
      it "正常なレスポンスか" do
        sign_in @member
        get :complete, params: {event_id: @event.id}
        expect(response).to be_success
      end
      it "200レスポンスが返ってきているか" do
        sign_in @member
        get :complete, params: {event_id: @event.id}
        expect(response).to have_http_status "200"
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        get :complete, params: {event_id: @event.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        get :complete, params: {event_id: @event.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
  describe "#create" do
    context "認証済みのユーザーとして" do
      it "イベント申し込みできるか" do
        sign_in @member
        expect {
          post :create, params: {
            event_member: {
              feedback: "良いイベントでした",
              rate: 3,
              event_id: @event.id,
              member_id: @member.id,
            },
            event_id: @event.id
          }
        }.to change(@event.event_members, :count).by(1)
      end
      it "申し込み後に完了ページにリダイレクトされているか" do
        sign_in @member
          post :create, params: {
            event_member: {
              feedback: "良いイベントでした",
              rate: 3,
              event_id: @event.id,
              member_id: @member.id,
            },
            event_id: @event.id
          }
        expect(response).to(redirect_to(event_event_members_complete_path))
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        post :create, params: {event_id: @event.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        post :create, params: {event_id: @event.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
  describe "#update" do
    context "認証済みのユーザーとして" do
      it "正常に更新できるか" do
        sign_in @member
        event_member_params = {feedback: "フィードバックを更新しました"}
        patch :update, params: {id: @event_member.id, event_id: @event.id, event_member: event_member_params}
        expect(@event_member.reload.feedback).to eq "フィードバックを更新しました"
      end
      it "更新後にイベント詳細ページにリダイレクトされているか" do
        sign_in @member
        event_member_params = {feedback: "フィードバックを更新しました"}
        patch :update, params: {id: @event_member.id, event_id: @event.id, event_member: event_member_params}
        expect(response).to redirect_to event_path(@event_member.event_id)
      end
      it "フォームが空白の時に更新できなくなっているか" do
        sign_in @member
        event_member_params = {feedback: ""}
        patch :update, params: {id: @event_member.id, event_id: @event.id, event_member: event_member_params}
        expect(@event_member.reload.feedback).to eq "良いイベントでした"
      end
      it "フォームが空白の時に更新できず、再度フィードバックページにリダイレクトされるか" do
        sign_in @member
        event_member_params = {feedback: ""}
        patch :update, params: {id: @event_member.id, event_id: @event.id, event_member: event_member_params}
        expect(response).to render_template(:show)
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        patch :update, params: {id: @event_member.id, event_id: @event.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        patch :update, params: {id: @event_member.id, event_id: @event.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
  # describe "#destroy" do
  #   context "認証済みのユーザーとして" do
  #     it "正常に投稿を削除できるか" do
  #       sign_in @member
  #       expect {
  #         delete :destroy, {params: {id: @event.id}}
  #       }.to change(@member.events, :count).by(-1)
  #     end
  #     it "削除後に現在のページにリダイレクトされているか" do
  #       sign_in @member
  #       delete :destroy, {params: {id: @event.id}}
  #       expect(response).to(redirect_to(events_myevent_path))
  #     end
  #   end
  #   context "未登録ユーザとして" do
  #     it "302レスポンスを返すか" do
  #       delete :destroy, params: {id: @event.id}
  #       expect(response).to have_http_status "302"
  #     end
  #     it "サインイン画面にリダイレクトするか" do
  #       delete :destroy, params: {id: @event.id}
  #       expect(response).to redirect_to "/members/sign_in"
  #     end
  #   end
  # end
  # describe "#myevent" do
  #   context "認証済みのユーザーとして" do
  #     it "正常なレスポンスか" do
  #       sign_in @member
  #       get :myevent
  #       expect(response).to be_success
  #     end
  #     it "200レスポンスが返ってきているか" do
  #       sign_in @member
  #       get :myevent
  #       expect(response).to have_http_status "200"
  #     end
  #   end
  #   context "未登録ユーザとして" do
  #     it "302レスポンスを返すか" do
  #       get :myevent
  #       expect(response).to have_http_status "302"
  #     end
  #     it "サインイン画面にリダイレクトするか" do
  #       get :myevent
  #       expect(response).to redirect_to "/members/sign_in"
  #     end
  #   end
  # end
end