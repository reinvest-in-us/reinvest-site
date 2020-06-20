class ConvertCityBudgetToBigInt < ActiveRecord::Migration[5.2]
  def change
    change_column :police_districts, :total_police_department_budget, :bigint
    change_column :police_districts, :total_general_fund_budget, :bigint
    change_column :police_districts, :total_police_paid_from_general_fund_budget, :bigint
  end
end
