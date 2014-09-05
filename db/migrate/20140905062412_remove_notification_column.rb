class RemoveNotificationColumn < ActiveRecord::Migration
  def up
  	remove_column :users, :notification
  end

  def down
  	add_column :users, :notification, :integer
  end
end
