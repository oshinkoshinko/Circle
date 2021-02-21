# frozen_string_literal: true

require 'rails_helper'

describe PostComment do
  describe '#create' do
    it " コメントがない場合は登録できないこと" do
      post_comment = build(:post_comment, comment:"")
      post_comment.valid?
      expect(post_comment.errors[:comment]).to include("を入力してください")
    end
  end

end