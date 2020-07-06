class AddBudgetLabelFieldToPoliceDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :police_districts, :budget_label, :string, null: true
  end
end
