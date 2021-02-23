# frozen_string_literal: true

require 'rails_helper'

describe Chat do
  describe '#create' do
    it " メッセージがない場合は登録できないこと" do
      chat = build(:chat, message:"")
      chat.valid?
      expect(chat.errors[:message]).to include("を入力してください")
    end
  end

end