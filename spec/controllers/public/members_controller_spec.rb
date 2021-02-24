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
        expect(response).to be_success
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

end