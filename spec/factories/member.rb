FactoryBot.define do

  factory :member do
    name  {"テスト太郎"}
    account_name  {"テス太"}
    email {"test@test.com"}
    password {"test"}
    password_confirmation {"test"}
  end

end