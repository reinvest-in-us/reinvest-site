class RemoveWhatToSay < ActiveRecord::Migration[5.2]
  def change
    remove_column :police_districts, :what_to_say
  end
end
