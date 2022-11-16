class AddReleaseDateToGame < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :release_date, :date
    add_column :games, :rating, :float
  end
end
