FactoryBot.define do
  factory :sound do
    text {Faker::Lorem.sentence}

    association :profile

    after(:build) do |sound|
      sound.sound.attach(io: File.open('spec/files/sound.m4a'), filename: 'sound.m4a')
    end
  end
end