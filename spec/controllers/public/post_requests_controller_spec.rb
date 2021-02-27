require 'rails_helper'

RSpec.describe Public::PostRequestsController, type: :controller do
  before do
    @genre = FactoryBot.create(:genre)
    @member = FactoryBot.create(:member)
    @post = FactoryBot.create(:post, {member: @member, genre: @genre})
    @post_request = FactoryBot.create(:post_request, {member: @member, post: @post})
  end

  describe "#waiting" do
    context "認証済みのユーザーとして" do
      it "正常なレスポンスか" do
        sign_in @member
        get :waiting
        expect(response).to be_success
      end
      it "200レスポンスが返ってきているか" do
        sign_in @member
        get :waiting
        expect(response).to have_http_status "200"
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        get :waiting
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        get :waiting
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
  describe "#create" do
    context "認証済みのユーザーとして" do
      it "リクエストできるか" do
        sign_in @member
        expect {
          post :create, params: {
            post_request: {
              is_requested: "true",
              is_accepted: "false",
              member_id: 1,
              post_id: 1,
            },
            post_id: @post.id
          }, xhr: true
        }.to change(@post.post_requests, :count).by(1)
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        post :create, params: {post_id: @post.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        post :create, params: {post_id: @post.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
  describe "#update" do
    context "認証済みのユーザーとして" do
      it "正常に更新できるか" do
        sign_in @member
        patch :update, {params: {id: @post_request.id, post_id: @post.id, is_accepted: "true", is_requested: "true"}, xhr: true}
        expect(@post_request.reload.is_accepted).to eq true
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        patch :update, {params: {id: @post_request.id, post_id: @post.id, is_accepted: "true", is_requested: "true"}, xhr: true}
        expect(response).to have_http_status "401"
      end
    end
  end
  describe "#destroy" do
    context "認証済みのユーザーとして" do
      it "正常にリクエストを削除できるか" do
        sign_in @member
        expect {
          delete :destroy, {params: {id: @post_request.id, post_id: @post.id}, xhr: true}
        }.to change(@post.post_requests, :count).by(-1)
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        delete :destroy, params: {post_id: @post.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        delete :destroy, params: {post_id: @post.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
end