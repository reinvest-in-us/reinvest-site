class AddAboutThisMeetingToMeeting < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :about, :text
  end
end
