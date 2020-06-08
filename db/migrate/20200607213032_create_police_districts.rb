class CreatePoliceDistricts < ActiveRecord::Migration[5.2]
  def change
    create_table :police_districts do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.integer :fy_2019_policing_budget

      t.timestamps
    end

    add_index :police_districts, :slug, unique: true
  end
end
