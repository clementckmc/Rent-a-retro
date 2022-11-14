class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :price, presence: true
  validates :platform, presence: true
end
