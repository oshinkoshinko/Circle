FactoryBot.define do

  factory :event_member do
    feedback  {"良いイベントでした"}
    rate {"3"}
    association :member
    association :event
  end

end