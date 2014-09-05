class AddNotificationColumn < ActiveRecord::Migration
  def up
  	add_column :users, :notification, :integer, :default => 0
  end

  def down
  	remove_column :users, :notification
  end
end
