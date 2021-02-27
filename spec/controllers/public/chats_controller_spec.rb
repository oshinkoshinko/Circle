require 'rails_helper'

RSpec.describe Public::ChatsController, type: :controller do
  before do
    @member = FactoryBot.create(:member)
    @room = FactoryBot.create(:room)
  end

  describe "#show" do
    context "認証済みのユーザーとして" do
      it "正常なレスポンスか" do
        sign_in @member
        get :show, params: {id: @member.id}
        expect(response).to be_successful
      end
      it "200レスポンスが返ってきているか" do
        sign_in @member
        get :show, params: {id: @member.id}
        expect(response).to have_http_status "200"
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        get :show, params: {id: @member.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        get :show, params: {id: @member.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
  describe "#create" do
    context "認証済みのユーザーとして" do
      it "メッセージ作成できるか" do
        sign_in @member
        expect {
          post :create, params: {
            chat: {
              message: "チャットを送りました",
              member_id: @member.id,
              room_id: @room.id,
            }
          }, xhr: true
        }.to change(@member.chats, :count).by(1)
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
end