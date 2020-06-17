class AddBudgetToDistrict < ActiveRecord::Migration[5.2]
  def change
      add_column :police_districts, :total_city_budget, :bigint, null: true
  end
end
