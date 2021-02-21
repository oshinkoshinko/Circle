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
    it " 確認用パスワードがない場合は登録できないこと" do
      member = build(:member, password_confirmation:"")
      member.valid?
      expect(member.errors[:password_confirmation]).to include("を入力してください")
    end
  end

end