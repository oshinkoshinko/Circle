require 'rails_helper'

RSpec.describe Public::PostsController, type: :controller do
  describe "#index" do
    before do
      @member = FactoryBot.create(:member)
    end
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
end