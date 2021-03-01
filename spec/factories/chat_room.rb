FactoryBot.define do

  factory :chat_room do
    association :member
    association :room
  end

end