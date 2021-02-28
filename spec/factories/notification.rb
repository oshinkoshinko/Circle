FactoryBot.define do

  factory :notification do
    association :visitor, factory: :member
    association :visited, factory: :member
    association :post
    association :post_comment
    checked       { true }
    action        { "comment" }
  end

end