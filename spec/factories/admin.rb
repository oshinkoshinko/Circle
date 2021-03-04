FactoryBot.define do

  factory :admin do
    email {"test@test.com"}
    password {"testtest"}
    password_confirmation {"testtest"}
  end

end