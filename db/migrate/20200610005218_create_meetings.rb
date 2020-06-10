class CreateMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :meetings do |t|
      t.datetime :event_datetime
      t.string :phone_number
      t.references :police_district, foreign_key: true
      t.timestamps
    end
  end
end
