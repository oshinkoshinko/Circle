require 'rails_helper'

RSpec.describe Public::RelationshipsController, type: :controller do
  before do
    @member = FactoryBot.create(:member)
    @other_member = FactoryBot.create(:member)
  end

  describe "#follow" do
    context "認証済みのユーザーとして" do
      it "正常なレスポンスか" do
        sign_in @member
        get :follow, params: {member_id: @member.id}
        expect(response).to be_successful
      end
      it "200レスポンスが返ってきているか" do
        sign_in @member
        get :follow, params: {member_id: @member.id}
        expect(response).to have_http_status "200"
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        get :follow, params: {member_id: @member.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        get :follow, params: {member_id: @member.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
  describe "#unfollow" do
    context "認証済みのユーザーとして" do
      it "正常なレスポンスか" do
        sign_in @member
        get :unfollow, params: {member_id: @member.id}
        expect(response).to be_successful
      end
      it "200レスポンスが返ってきているか" do
        sign_in @member
        get :unfollow, params: {member_id: @member.id}
        expect(response).to have_http_status "200"
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        get :unfollow, params: {member_id: @member.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        get :unfollow, params: {member_id: @member.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
  describe "#create" do
    context "認証済みのユーザーとして" do
      it "フォローできるか" do
        sign_in @member
        expect {
          post :create, params: {
            relationship: {
              member_id: @other_member.id,
            },
            member_id: @member.id
          }, xhr: true
        }.to change(@member.following_member, :count).by(1)
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        post :create, params: {member_id: @member.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        post :create, params: {member_id: @member.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
  describe "#destroy" do
    context "認証済みのユーザーとして" do
      it "正常にフォローを解除できるか" do
        sign_in @member
        expect {
          delete :destroy, params: {
            relationship: {
              member_id: @other_member.id,
            },
            member_id: @other_member.id,
          }, xhr: true
        }.to change(@member.following_member, :count).by(-1)
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        delete :destroy, params: {member_id: @member.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        delete :destroy, params: {member_id: @member.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
end