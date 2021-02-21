FactoryBot.define do

  factory :member do
    name  {"テスト太郎"}
    account_name  {"テス太"}
    email {"test@test.com"}
    password {"testtest"}
    password_confirmation {"testtest"}
  end

end