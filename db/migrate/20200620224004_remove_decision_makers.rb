class RemoveDecisionMakers < ActiveRecord::Migration[5.2]
  def change
    remove_column :police_districts, :decision_makers, :string, null: true
  end
end
