class Sound < ApplicationRecord
  validates :sound, :text, presence: true
  belongs_to :profile
  has_many :comments, dependent: :destroy
  has_one_attached :sound
end
