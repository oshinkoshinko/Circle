require 'rails_helper'

RSpec.describe Public::NotificationsController, type: :controller do
  before do
    @member = FactoryBot.create(:member)
    @other_member = FactoryBot.create(:member)
    @other_genre = Genre.create(name: "テスト")
    @post = FactoryBot.create(:post, {member: @member, genre: @other_genre})
    @post_comment = FactoryBot.create(:post_comment, {member: @member, post: @post})
    @notification = FactoryBot.create(:notification, { post: @post, post_comment: @post_comment })
  end

  describe "#index" do
    context "認証済みのユーザーとして" do
      it "正常なレスポンスか" do
        sign_in @member
        get :index
        expect(response).to be_successful
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
  describe "#destroy" do
    context "認証済みのユーザーとして" do
      it "正常に通知を全て削除できるか" do
        sign_in @member
        @destroy_notifications = @member.passive_notifications.create(
          visited_id: @member.id,
          visitor_id: @other_member.id,
          post_comment_id: @post_comment.id,
          action: 'comment',
          checked: false)
        expect {
          delete :destroy_all, params: {id: @destroy_notifications.id }
        }.to change(Notification, :count).by(-1)
      end
    end
    context "未登録ユーザとして" do
      it "302レスポンスを返すか" do
        delete :destroy_all
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトするか" do
        delete :destroy_all
        expect(response).to redirect_to "/members/sign_in"
      end
    end
  end
end