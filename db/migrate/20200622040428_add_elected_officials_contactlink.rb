class AddElectedOfficialsContactlink < ActiveRecord::Migration[5.2]
  def change
    add_column :police_districts, :elected_officials_contact_link, :string, null: true
  end
end
