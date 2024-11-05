FactoryBot.define do
  factory :profile do
    name {Faker::Lorem.sentence}
    text {Faker::Lorem.sentence}

    association :user

    after(:build) do |profile|
      profile.image.attach(io: File.open('app/assets/images/avatar.jpg'), filename: 'avatar.jpg')
    end
  end
end