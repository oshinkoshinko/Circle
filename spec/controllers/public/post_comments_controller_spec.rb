require 'rails_helper'

RSpec.describe Public::PostCommentsController, type: :controller do
  before do
    @genre = FactoryBot.create(:genre)
    @member = FactoryBot.create(:member)
    @post = FactoryBot.create(:post, {member: @member, genre: @genre})
    @post_comment = FactoryBot.create(:post_comment, {member: @member, post: @post})
  end

  describe "#show" do
    context "認証済みのユーザーとして" do
      it "正常なレスポンスか" do
        sign_in @member
        get :show, params: {id: @post.id}
        expect(response).to be_success
      end
      it "200レスポンスが返ってきているか" do
        sign_in @member
        get :show, params: {id: @post.id}
        expect(response).to have_http_status "200"
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        get :show, params: {id: @post.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        get :show, params: {id: @post.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
  describe "#create" do
    context "認証済みのユーザーとして" do
      it "投稿できるか" do
        sign_in @member
        expect {
          post :create, params: {
            post_comment: {
              comment: "コメントしたよ",
              member_id: 1,
              post_id: 1,
            }
          }, xhr: true
        }.to change(@post.post_comments, :count).by(1)
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        post :create, params: {id: @post.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        post :create, params: {id: @post.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
  describe "#destroy" do
    context "認証済みのユーザーとして" do
      it "正常に投稿を削除できるか" do
        sign_in @member
        expect {
          delete :destroy, {params: {id: @post_comment.id}, xhr: true}
        }.to change(@post.post_comments, :count).by(-1)
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        delete :destroy, params: {id: @post.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        delete :destroy, params: {id: @post.id}
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
end