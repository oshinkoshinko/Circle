require 'rails_helper'

RSpec.describe Admin::GenresController, type: :controller do
  before do
    @admin = FactoryBot.create(:admin)
    @genre = FactoryBot.create(:genre)
  end
  describe "#index" do
    context "管理者として" do
      it "正常なレスポンスか" do
        sign_in @admin
        get :index
        expect(response).to be_successful
      end
      it "200レスポンスが返ってきているか" do
        sign_in @admin
        get :index
        expect(response).to have_http_status "200"
      end
    end
    context "管理者以外として" do
      it "302レスポンスを返すか" do
        get :index
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        get :index
        expect(response).to redirect_to "/admins/sign_in"
      end
    end
  end
  describe "#create" do
    context "管理者として" do
      it "ジャンルを追加できるか" do
        sign_in @admin
        expect {
          post :create, params: {
            genre: {
              name: "スポーツ",
            }
          }
        }.to change(Genre, :count).by(1)
      end
    end
    context "管理者以外として" do
      it "302レスポンスを返すか" do
        post :create
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        post :create
        expect(response).to redirect_to "/admins/sign_in"
      end
    end
  end
  describe "#destroy" do
    context "管理者として" do
      it "正常にジャンルを削除できるか" do
        sign_in @admin
        expect {
          delete :destroy, {params: {id: @genre.id}}
        }.to change(Genre, :count).by(-1)
      end
    end
    context "管理者以外として" do
      it "302レスポンスを返すか" do
        delete :destroy, params: {id: @genre.id}
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        delete :destroy, params: {id: @genre.id}
        expect(response).to redirect_to "/admins/sign_in"
      end
    end
  end
end