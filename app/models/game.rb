class Game < ApplicationRecord
  has_many :offers, dependent: :destroy
  has_many :rentals, through: :offers, dependent: :destroy
  has_many :users, through: :offers
  has_one_attached :photo

  validates :name, presence: true
  validates :description, presence: true

  include PgSearch::Model

  pg_search_scope :search,
                  against: [ :name ],
                  using: { tsearch: { prefix: true } }
end
