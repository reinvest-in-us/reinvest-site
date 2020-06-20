class SplitOutGeneralFundStats < ActiveRecord::Migration[5.2]
  def change
    rename_column :police_districts, :fy_2019_policing_budget, :total_police_department_budget
    rename_column :police_districts, :total_city_budget, :total_district_budget

    add_column :police_districts, :total_general_fund_budget, :integer
    add_column :police_districts, :total_police_paid_from_general_fund_budget, :integer

    remove_column :police_districts, :general_fund_percent
  end
end
