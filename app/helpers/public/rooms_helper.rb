module Public::RoomsHelper

  # 最新メッセージのデータを取得して表示するメソッド
  def most_new_message_preview(room)
    # 最新メッセージのデータを取得する
    chat = room.chats.order(updated_at: :desc).limit(1)
    # 配列から取り出す
    chat = chat[0]
    # メッセージの有無を判定
    if chat.present?
      # メッセージがあれば内容を表示
      tag.p "#{chat.message}", class: "dm_list__content__link__box__message"
    else
      # メッセージがなければ[ まだメッセージはありません ]を表示
      tag.p "[ まだメッセージはありません ]", class: "dm_list__content__link__box__message"
    end
  end

  # 相手ユーザー名を取得して表示するメソッド
  def opponent_member_name(room)
    # 中間テーブルから相手ユーザーのデータを取得
    chatroom = room.chat_rooms.where.not(member_id: current_member)
    # 相手ユーザーの名前を取得
    account_name = chatroom[0].member.account_name
  end

  # 相手ユーザー情報を取得して表示するメソッド
  def opponent_member(room)
    # 中間テーブルから相手ユーザーのデータを取得
    chatroom = room.chat_rooms.where.not(member_id: current_member)
    # 相手ユーザー情報を取得
    account = chatroom[0].member
  end

end
