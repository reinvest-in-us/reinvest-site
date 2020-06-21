class AddMeetingLinkToMeeting < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :video_link, :string, null: true
  end
end
