require 'rails_helper'

RSpec.describe Public::MembersController, type: :controller do
  before do
    @member = FactoryBot.create(:member)
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
  describe "#edit" do
    context "認証済みのユーザーとして" do
      it "正常なレスポンスか" do
        sign_in @member
        get :edit, params: {id: @member.id}
        expect(response).to be_successful
      end
      it "200レスポンスが返ってきているか" do
        sign_in @member
        get :edit, params: {id: @member.id}
        expect(response).to have_http_status "200"
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        get :edit, params: {id: @member.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        get :edit, params: {id: @member.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
  describe "#update" do
    context "認証済みのユーザーとして" do
      it "正常に更新できるか" do
        sign_in @member
        member_params = {introduction: "会員情報更新しました",}
        patch :update, params: {id: @member.id, member: member_params}
        expect(@member.reload.introduction).to eq "会員情報更新しました"
      end
      it "更新後にマイページにリダイレクトされているか" do
        sign_in @member
        member_params = {introduction: "会員情報更新しました",}
        patch :update, params: {id: @member.id, member: member_params}
        expect(response).to redirect_to member_path(@member.id)
      end
      it "フォームが空白の時に更新できなくなっているか" do
        sign_in @member
        member_params = {account_name: ""}
        patch :update, params: {id: @member.id, member: member_params}
        expect(@member.reload.account_name).to eq @member.account_name
      end
      it "フォームが空白の時に更新できず、再度編集ページにリダイレクトされるか" do
        sign_in @member
        member_params = {account_name: ""}
        patch :update, params: {id: @member.id, member: member_params}
        expect(response).to render_template(:edit)
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        get :update, params: {id: @member.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        get :update, params: {id: @member.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
  describe "#withdraw" do
    context "認証済みのユーザーとして" do
      it "正常なレスポンスか" do
        sign_in @member
        get :withdraw, params: {id: @member.id}
        expect(response).to be_successful
      end
      it "200レスポンスが返ってきているか" do
        sign_in @member
        get :withdraw, params: {id: @member.id}
        expect(response).to have_http_status "200"
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        get :withdraw, params: {id: @member.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        get :withdraw, params: {id: @member.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
  describe "#unsubscribe" do
    context "認証済みのユーザーとして" do
      it "正常に更新できるか" do
        sign_in @member
        member_params = {is_deleted: true,}
        patch :unsubscribe, params: {id: @member.id, member: member_params}
        expect(@member.reload.is_deleted).to eq true
      end
      it "更新後にマイページにリダイレクトされているか" do
        sign_in @member
        member_params = {is_deleted: true,}
        patch :unsubscribe, params: {id: @member.id, member: member_params}
        expect(response).to redirect_to root_path
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        get :unsubscribe, params: {id: @member.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        get :unsubscribe, params: {id: @member.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
end