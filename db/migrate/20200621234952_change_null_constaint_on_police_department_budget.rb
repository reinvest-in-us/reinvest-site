class ChangeNullConstaintOnPoliceDepartmentBudget < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:police_districts, :total_police_department_budget, false)
  end
end
