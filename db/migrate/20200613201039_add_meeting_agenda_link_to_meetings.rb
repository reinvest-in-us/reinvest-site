class AddMeetingAgendaLinkToMeetings < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :agenda_link, :string, null: true
    add_column :police_districts, :decision_makers, :string, null: true
    add_column :police_districts, :what_to_say, :text, null: true
    add_column :police_districts, :how_to_comment, :text, null: true
  end
end
