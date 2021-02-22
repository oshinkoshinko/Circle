FactoryBot.define do

  factory :member do
    name  {"テスト太郎"}
    #sequenceでオブジェクト作成ごとにカウンタを増やし、ユニークにする
    sequence(:account_name)  { |n| "テス太#{n}"}
    sequence(:email) { |n| "test#{n}@test.com"}
    password {"testtest"}
    password_confirmation {"testtest"}
  end

end