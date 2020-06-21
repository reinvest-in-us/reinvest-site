class RemovePhoneNumberFromMeetings < ActiveRecord::Migration[5.2]
  def change
    remove_column :meetings, :phone_number
  end
end
