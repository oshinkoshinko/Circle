FactoryBot.define do

  factory :event do
    name  {"チーム開発"}
    content {"チームでECサイトを作ろう！"}
    place {"新宿"}
    fee {"100"}
    started_at { "2021-02-10 00:00:00"}
    finished_at { "2021-02-11 00:00:00" }
    expired_at { "2021-02-01 00:00:00" }
    association :member
    association :genre
  end

end