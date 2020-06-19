class AddGeneralFundPercentToDistrict < ActiveRecord::Migration[5.2]
  def change
    add_column :police_districts, :general_fund_percent, :int, null: true
  end
end
