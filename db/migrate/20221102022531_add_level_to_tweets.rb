class AddLevelToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :level, :integer
  end
end
