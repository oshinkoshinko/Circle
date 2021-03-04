FactoryBot.define do

  factory :event_member do
    feedback  {"良いイベントでした"}
    score {"0.5"}
    association :member
    association :event
  end

end