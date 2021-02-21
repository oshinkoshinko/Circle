FactoryBot.define do

  factory :post do
    body      {"railsを勉強します！"}
    address   {"東京都"}
    genre_id  { 1 }
  end

end