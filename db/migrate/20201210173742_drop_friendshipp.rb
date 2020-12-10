class DropFriendshipp < ActiveRecord::Migration[5.2]
  def change
    drop_table :friendshipps
  end
end
