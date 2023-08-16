class AddRoomIdToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :room_id, :integer
  end
end
