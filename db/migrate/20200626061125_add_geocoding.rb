class AddGeocoding < ActiveRecord::Migration[5.2]
  def change
    add_column :police_districts, :latitude, :float, null: true
    add_column :police_districts, :longitude, :float, null: true
    add_column :police_districts, :address, :string, null: true
  end
end
