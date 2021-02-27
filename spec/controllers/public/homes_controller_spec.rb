require 'rails_helper'

RSpec.describe Public::HomesController, type: :controller do
  describe "#top" do
    it "正常にレスポンスを返すこと" do
      get :top
      expect(response).to be_successful
    end
  end
end