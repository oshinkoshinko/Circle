require 'rails_helper'

RSpec.describe Public::PostsController, type: :controller do
  before do
    @member = FactoryBot.create(:member)
    @post = FactoryBot.create(:post)
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
  describe "#create" do
    # context "認証済みのユーザーとして" do
    #   it "投稿できるか" do
    #     # post_params = FactoryBot.attributes_for(:post)
    #     sign_in @member
    #     expect {
    #       post :create, params: {
    #         post: {
    #           body: "投稿したよ",
    #           address: "東京",
    #           genre_id: 1,
    #           member_id: 1,
    #         }
    #       }
    #     }.to change(@member.posts, :count).by(1)
    #   end
    #   it "投稿後にマイページにリダイレクトされているか" do
    #     sign_in @member
    #       post :create, params: {
    #         post: {
    #           body: "投稿したよ",
    #           address: "東京",
    #           genre_id: 1,
    #           member_id: 1,
    #         }
    #       }
    #     expect(response).to redirect_to request.referer
    #   end
    # end
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
  describe "#edit" do
    context "認証済みのユーザーとして" do
      it "正常なレスポンスか" do
        sign_in @member
        get :edit, params: {id: @post.id}
        expect(response).to be_success
      end
      it "200レスポンスが返ってきているか" do
        sign_in @member
        get :edit, params: {id: @post.id}
        expect(response).to have_http_status "200"
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        get :edit, params: {id: @post.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        get :edit, params: {id: @post.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
end