class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :rentals, dependent: :destroy

  validates :price, presence: true
  validates :platform, presence: true
end
