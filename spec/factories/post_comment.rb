FactoryBot.define do

  factory :post_comment do
    comment  {"いいですね！"}
    association :member
    association :post
  end

end