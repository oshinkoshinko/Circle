FactoryBot.define do

  factory :event do
    name  {"チーム開発"}
    content {"チームでECサイトを作ろう"}
    place {"新宿"}
    fee {"100"}
    genre_id { 1 }
    member_id { 2 }
    started_at { 202101010000 }
    finished_at { 202101010000 }
    expired_at { 202101010000 }
  end

end