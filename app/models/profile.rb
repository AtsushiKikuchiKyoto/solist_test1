class Profile < ApplicationRecord
  validates :name, presence: true
  validates :text, presence: true
  has_one_attached :image
  belongs_to :user
  has_many :sounds
  has_many :comments
  
end
