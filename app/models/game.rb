class Game < ApplicationRecord
  has_many :offers
  has_many :rentals, through: :offers
  has_many :users, through: :offers
  has_one_attached :photo

  validates :name, presence: :true
  validates :description, presence: :true
end
