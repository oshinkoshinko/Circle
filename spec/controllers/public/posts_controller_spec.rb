require 'rails_helper'

RSpec.describe Public::PostsController, type: :controller do
  before do
    @genre = create(:genre)
    @member = FactoryBot.create(:member)
    @post = FactoryBot.create(:post, {member: @member, genre: @genre})
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
    context "認証済みのユーザーとして" do
      it "投稿できるか" do
        sign_in @member
        expect {
          post :create, params: {
            post: {
              body: "投稿したよ",
              address: "東京",
              genre_id: 1,
              member_id: 1,
            }
          }
        }.to change(@member.posts, :count).by(1)
      end
      it "投稿後にマイページにリダイレクトされているか" do
        sign_in @member
          post :create, params: {
            post: {
              body: "投稿したよ",
              address: "東京",
              genre_id: 1,
              member_id: 1,
            }
          }
        expect(response).to(redirect_to(member_path(@member)))
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
  describe "#update" do
    context "認証済みのユーザーとして" do
      it "正常に更新できるか" do
        sign_in @member
        post_params = {body: "更新しました"}
        patch :update, params: {id: @post.id, post: post_params}
        expect(@post.reload.body).to eq "更新しました"
      end
      it "更新後にマイページにリダイレクトされているか" do
        sign_in @member
        post_params = {body: "更新しました"}
        patch :update, params: {id: @post.id, post: post_params}
        expect(response).to redirect_to member_path(@member.id)
      end
      it "フォームが空白の時に更新できなくなっているか" do
        sign_in @member
        post_params = {body: ""}
        patch :update, params: {id: @post.id, post: post_params}
        expect(@post.reload.body).to eq "railsを勉強します！"
      end
      it "フォームが空白の時に更新できず、再度編集ページにリダイレクトされるか" do
        sign_in @member
        post_params = {body: ""}
        patch :update, params: {id: @post.id, post: post_params}
        expect(response).to render_template(:edit)
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
  describe "#destroy" do
    context "認証済みのユーザーとして" do
      it "正常に投稿を削除できるか" do
        sign_in @member
        expect {
          delete :destroy, {params: {id: @post.id}}
        }.to change(@member.posts, :count).by(-1)
      end
      it "削除後に現在のページにリダイレクトされているか" do
        sign_in @member
        delete :destroy, {params: {id: @post.id}}
        expect(response).to(redirect_to(member_path(@member)))
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