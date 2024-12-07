class Sound < ApplicationRecord
  validates :text, presence: true
  belongs_to :profile
  has_many :comments, dependent: :destroy
  has_one_attached :sound

  validates :sound, attached: true, content_type: ['audio/mpeg', 'audio/wav', 'audio/ogg', 'audio/mp4', 'audio/x-m4a', 'audio/webm']

end
