FactoryBot.define do

  factory :post do
    body      {"railsを勉強します！"}
    address   {"東京都"}
    association :member
    association :genre
  end

end