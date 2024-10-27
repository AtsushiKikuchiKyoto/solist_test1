class Comment < ApplicationRecord
  validates :text, presence: true
  belongs_to :profile
  belongs_to :sound
end
