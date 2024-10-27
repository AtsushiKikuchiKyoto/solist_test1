class Sound < ApplicationRecord
  validates :sound, :text, presence: true
  belongs_to :profile
  has_many :comments
  has_one_attached :sound
end
