class AddPlattformToOffer < ActiveRecord::Migration[7.0]
  def change
    add_column :offers, :plattform, :string
  end
end
