class Notification < ApplicationRecord

  #default_scopeで通知の並び順を作成日時順にしている
  default_scope -> { order(created_at: :desc) }
  #optional_trueを付けて、nilを許可 belongs_toの設定ではnilは許可されない
  belongs_to :post, optional: true
  belongs_to :post_comment, optional: true

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

end
