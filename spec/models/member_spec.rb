# frozen_string_literal: true

require 'rails_helper'

describe Member do
  describe '#create' do
    it " 名前がない場合は登録できないこと" do
      member = build(:member, name:"")
      member.valid?
      expect(member.errors[:name]).to include("を入力してください")
    end
    it " アカウント名がない場合は登録できないこと" do
      member = build(:member, account_name:"")
      member.valid?
      expect(member.errors[:account_name]).to include("を入力してください")
    end
    it "重複したアカウント名は登録できないこと" do
      Member.create(
        name: "テスト次郎",
        account_name: "テス太",
        email: "test2@test.com",
        password: "test2test2",
        password_confirmation: "test2test2"
        )
      member = Member.new(
        name: "テスト次郎",
        account_name: "テス太",
        email: "test2@test.com",
        password: "test2test2",
        password_confirmation: "test2test2"
        )
      member.valid?
      expect(member.errors[:account_name]).to include("はすでに存在します")
    end
    it " メールアドレスがない場合は登録できないこと" do
      member = build(:member, email:"")
      member.valid?
      expect(member.errors[:email]).to include("を入力してください")
    end
    it " パスワードがない場合は登録できないこと" do
      member = build(:member, password:"")
      member.valid?
      expect(member.errors[:password]).to include("を入力してください")
    end
  end

end