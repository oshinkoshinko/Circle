require 'rails_helper'

RSpec.describe Admin::MembersController, type: :controller do
  before do
    @admin = FactoryBot.create(:admin)
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
end