# frozen_string_literal: true

require 'rails_helper'

describe Event, type: :model do
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
    it " 同一ユーザーが同じイベント開催日時を設定できないこと" do
      member = Member.create(
        name: "あいうえお",
        account_name: "あいう",
        email: "aiu@p",
        password: "000000",
        password_confirmation: "000000"
        )
      genre = Genre.create(
        name: "プログラミング",
      )
      member.events.create(
        name: "チーム開発",
        content: "チームでECサイトを作ろう",
        place: "新宿",
        fee: "100",
        genre_id: "1",
        started_at: "2021-02-10 00:00:00",
        finished_at: "2021-02-10 00:00:00",
        expired_at: "2021-02-10 00:00:00",
        )
      new_event = member.events.build(
        name: "チーム開発2",
        content: "チームでECサイト2を作ろう",
        place: "新宿2",
        fee: "1000",
        genre_id: "1",
        started_at: "2021-02-10 00:00:00",
        finished_at: "2021-02-10 00:00:00",
        expired_at: "2021-02-10 00:00:00",
        )
      new_event.valid?
      expect(new_event.errors[:started_at]).to include("はすでに存在します")
    end
    it " 他のユーザーが同じ開催日時を使うことは許可すること" do
      member = Member.create(
        name: "テスト四郎",
        account_name: "テス四",
        email: "test@test.com",
        password: "testtest",
        password_confirmation: "testtest"
        )
      genre = Genre.create(
        name: "プログラミング",
      )
      member.events.create(
        name: "チーム開発",
        content: "チームでECサイトを作ろう",
        place: "新宿",
        fee: "100",
        genre_id: "1",
        started_at: "2021-02-10 00:00:00",
        finished_at: "2021-02-10 00:00:00",
        expired_at: "2021-02-10 00:00:00",
        )
      other_member = Member.create(
        name: "テスト五郎",
        account_name: "テス五",
        email: "test2@test.com",
        password: "test2test2",
        password_confirmation: "test2test2"
        )
      other_event = other_member.events.build(
        name: "チーム開発",
        content: "チームでECサイトを作ろう２",
        place: "新宿",
        fee: "100",
        genre_id: "1",
        started_at: "2021-02-10 00:00:00",
        finished_at: "2021-02-10 00:00:00",
        expired_at: "2021-02-10 00:00:00",
        )
      expect(other_event).to be_valid
    end
  end

end