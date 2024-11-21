class Profile < ApplicationRecord
  validates :name, presence: true
  validates :text, presence: true
  has_one_attached :image
  belongs_to :user
  has_many :sounds, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/gif'], size: { less_than: 2.megabytes }
end
