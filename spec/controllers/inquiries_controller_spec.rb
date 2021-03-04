require 'rails_helper'

RSpec.describe InquiriesController, type: :controller do
  before do
    @inquiry = FactoryBot.create(:inquiry)
  end

  describe "#new" do
    context "お問い合わせ画面表示は" do
      it "正常なレスポンスか" do
        get :new
        expect(response).to be_successful
      end
      it "200レスポンスが返ってきているか" do
        get :new
        expect(response).to have_http_status "200"
      end
    end
  end
  describe "#create" do
    context "お問い合わせとして" do
      it "メッセージ作成できるか" do
        expect {
          post :create, params: {
            inquiry: {
              name: "太郎",
              message: "問い合わせました",
              email: "taro@p"
            }
          }
        }.to change(Inquiry, :count).by(1)
      end
    end
  end
end