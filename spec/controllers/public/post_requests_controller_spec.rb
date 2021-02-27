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

end