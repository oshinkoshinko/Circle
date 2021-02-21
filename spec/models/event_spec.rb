# frozen_string_literal: true

require 'rails_helper'

describe Event do
  describe '#create' do
    it " イベント名がない場合は登録できないこと" do
      event = build(:event, name:"")
      event.valid?
      expect(event.errors[:name]).to include("を入力してください")
    end
    it " イベント内容がない場合は登録できないこと" do
      event = build(:event, content:"")
      event.valid?
      expect(event.errors[:content]).to include("を入力してください")
    end
    it " 場所がない場合は登録できないこと" do
      event = build(:event, place:"")
      event.valid?
      expect(event.errors[:place]).to include("を入力してください")
    end
    it " 参加費がない場合は登録できないこと" do
      event = build(:event, fee:"")
      event.valid?
      expect(event.errors[:fee]).to include("を入力してください")
    end
  end

end