class AddTimeZoneToPoliceDistrict < ActiveRecord::Migration[5.2]
  def change
    add_column :police_districts, :timezone, :string
  end
end
