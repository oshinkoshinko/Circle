FactoryBot.define do

  factory :relationship do
    association :follower, factory: :member
    association :followed, factory: :member
  end

end