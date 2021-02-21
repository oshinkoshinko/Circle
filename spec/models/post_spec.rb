# frozen_string_literal: true

require 'rails_helper'

describe Post do
  describe '#create' do
    it " 内容がない場合は登録できないこと" do
      post = build(:post, body:"")
      post.valid?
      expect(post.errors[:body]).to include("を入力してください")
    end
    it " 場所がない場合は登録できないこと" do
      post = build(:post, address:"")
      post.valid?
      expect(post.errors[:address]).to include("を入力してください")
    end
    it " ジャンルがない場合は登録できないこと" do
      post = build(:post, genre_id:"")
      post.valid?
      expect(post.errors[:genre_id]).to include("を入力してください")
    end
  end
end