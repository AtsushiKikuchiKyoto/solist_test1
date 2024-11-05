FactoryBot.define do
  factory :comment do
    text {Faker::Lorem.sentence}

    association :profile
    association :sound
  end
end