require 'rails_helper'

RSpec.describe Public::RelationshipsController, type: :controller do
  before do
    @member = FactoryBot.create(:member)
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
  # describe "#create" do
  #   context "認証済みのユーザーとして" do
  #     it "リクエストできるか" do
  #       sign_in @member
  #       expect {
  #         post :create, params: {
  #           post_request: {
  #             is_requested: "true",
  #             is_accepted: "false",
  #             member_id: @member.id,
  #             post_id: @post.id,
  #           },
  #           post_id: @post.id
  #         }, xhr: true
  #       }.to change(@post.post_requests, :count).by(1)
  #     end
  #   end
  #   context "未登録ユーザとして" do
  #     it "302レスポンスを返すか" do
  #       post :create, params: {post_id: @post.id}
  #       expect(response).to have_http_status "302"
  #     end
  #     it "サインイン画面にリダイレクトするか" do
  #       post :create, params: {post_id: @post.id}
  #       expect(response).to redirect_to "/members/sign_in"
  #     end
  #   end
  # end
  # describe "#destroy" do
  #   context "認証済みのユーザーとして" do
  #     it "正常にリクエストを削除できるか" do
  #       sign_in @member
  #       expect {
  #         delete :destroy, {params: {id: @post_request.id, post_id: @post.id}, xhr: true}
  #       }.to change(@post.post_requests, :count).by(-1)
  #     end
  #   end
  #   context "未登録ユーザとして" do
  #     it "302レスポンスを返すか" do
  #       delete :destroy, params: {post_id: @post.id}
  #       expect(response).to have_http_status "302"
  #     end
  #     it "サインイン画面にリダイレクトするか" do
  #       delete :destroy, params: {post_id: @post.id}
  #       expect(response).to redirect_to "/members/sign_in"
  #     end
  #   end
  # end
end