FactoryBot.define do

  factory :post_request do
    is_requested { true }
    is_accepted { true }
    association :member
    association :post
  end

end