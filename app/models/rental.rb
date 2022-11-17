# @format

class Rental < ApplicationRecord
  # STATUS = %w(requested accepted denied sent received)
  enum status: {
         requested: "requested",
         accepted: "accepted",
         rejected: "rejected",
       },
       _default: :requested

  belongs_to :user
  belongs_to :offer
end
