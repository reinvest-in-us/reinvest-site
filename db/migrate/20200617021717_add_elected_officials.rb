class AddElectedOfficials < ActiveRecord::Migration[5.2]
  def change
    create_table :elected_officials do |t|
      t.string :name, null: false
      t.string :position, null: false
      t.string :reelection_date, null: true
      t.belongs_to :police_district, null: false

      t.timestamps
    end
  end
end
