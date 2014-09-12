class AlterUsersTable < ActiveRecord::Migration

  def up
  	remove_column :users, :first_name
  	remove_column :users, :last_name
  	remove_column :users, :profile_name
  end

  def down
  	add_column :users, :first_name
  	add_column :users, :last_name
  	add_column :users, :profile_name
  end
end
