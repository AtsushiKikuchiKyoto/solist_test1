require 'open-uri'

user1 = User.create!(
  email: 'aaa@aaa.aaa',
  password: "abcde12345",
  password_confirmation: "abcde12345"
)

user2 = User.create!(
  email: 'bbb@bbb.bbb',
  password: "abcde12345",
  password_confirmation: "abcde12345"
)

# -----------------------------------------

profile1 = user1.profiles.new(
  name: 'beethoven',
  text: 'I am Beethoven'
)
profile1.save!(validate: false)
profile1.image.attach(
  io: File.open('db/files/beethoven.jpg'),
  filename: 'beethoven.jpg',
  content_type: 'image/jpeg'
)
profile1.save!

profile2 = user2.profiles.new(
  name: 'ピアノマン',
  text: 'ピアノを練習しています。仲良くしてください！'
)
profile2.save!(validate: false)
profile2.image.attach(
  io: File.open('db/files/piano.jpg'),
  filename: 'piano.jpg',
  content_type: 'image/jpeg'
)
profile2.save!

profile3 = user1.profiles.new(
  name: '染色家',
  text: '趣味で音楽をしています。本業は染色家です。よろしくお願いします。'
)
profile3.save!(validate: false)
profile3.image.attach(
  io: File.open('db/files/note.jpg'),
  filename: 'note.jpg',
  content_type: 'image/jpeg'
)
profile3.save!

profile4 = user2.profiles.new(
  name: 'Trumpetter',
  text: 'ふとトランペットを始めました。綺麗な音を出すのが難しいです。気長にやります！'
)
profile4.save!(validate: false)
profile4.image.attach(
  io: File.open('db/files/trumpet.jpg'),
  filename: 'trumpet.jpg',
  content_type: 'image/jpeg'
)
profile4.save!

# -----------------------------------------

sound2 = profile1.sounds.new(
  text: 'moonlight sonata 2'
)
sound2.save!(validate: false)
sound2.sound.attach(
  io: File.open('db/files/moonlight2.m4a'),
  filename: 'moonlight2.m4a',
  content_type: 'audio/x-m4a'
)
sound2.save!

sound5 = profile3.sounds.new(
  text: 'J-pop!'
)
sound5.save!(validate: false)
sound5.sound.attach(
  io: File.open('db/files/pops.m4a'),
  filename: 'pops.m4a',
  content_type: 'audio/x-m4a'
)
sound5.save!

sound1 = profile1.sounds.new(
  text: 'moonlight sonata 1'
)
sound1.save!(validate: false)
sound1.sound.attach(
  io: File.open('db/files/moonlight1.m4a'),
  filename: 'moonlight1.m4a',
  content_type: 'audio/x-m4a'
)
sound1.save!

sound6 = profile4.sounds.new(
  text: 'はとと少年'
)
sound6.save!(validate: false)
sound6.sound.attach(
  io: File.open('db/files/trumpet.m4a'),
  filename: 'trumpet.m4a',
  content_type: 'audio/x-m4a'
)
sound6.save!

sound4 = profile2.sounds.new(
  text: 'バッハ クラヴィーア曲集'
)
sound4.save!(validate: false)
sound4.sound.attach(
  io: File.open('db/files/bach.m4a'),
  filename: 'bach.m4a',
  content_type: 'audio/x-m4a'
)
sound4.save!

sound3 = profile1.sounds.new(
  text: 'エリーゼのために'
)
sound3.save!(validate: false)
sound3.sound.attach(
  io: File.open('db/files/elese.m4a'),
  filename: 'elese.m4a',
  content_type: 'audio/x-m4a'
)
sound3.save!

