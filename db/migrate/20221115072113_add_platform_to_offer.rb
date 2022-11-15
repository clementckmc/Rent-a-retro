class AddPlatformToOffer < ActiveRecord::Migration[7.0]
  def change
    add_column :offers, :platform, :string
  end
end
