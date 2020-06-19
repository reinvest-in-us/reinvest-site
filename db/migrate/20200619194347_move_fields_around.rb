class MoveFieldsAround < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :agenda_details, :text, null: true
    remove_column :police_districts, :how_to_comment, :string, null: true
    add_column :meetings, :how_to_comment, :text, null: true
    add_column :police_districts, :decision_makers_text, :text, null: true
    add_column :police_districts, :law_enforcement_gets_more_than_1, :string, null: true 
    add_column :police_districts, :law_enforcement_gets_more_than_1_dollars, :bigint, null: true 
    add_column :police_districts, :law_enforcement_gets_more_than_2, :string, null: true 
    add_column :police_districts, :law_enforcement_gets_more_than_2_dollars, :bigint, null: true 
    add_column :police_districts, :law_enforcement_gets_more_than_3, :string, null: true 
    add_column :police_districts, :law_enforcement_gets_more_than_3_dollars, :bigint, null: true 
  end
end
