class Rental < ApplicationRecord
  STATUS = %w(requested accepted denied sent received)

  belongs_to :user
  belongs_to :offer
  validates :status, presence: true, inclusion: { in: STATUS }
end
