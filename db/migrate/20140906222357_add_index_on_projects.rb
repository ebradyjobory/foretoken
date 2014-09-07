class AddIndexOnProjects < ActiveRecord::Migration

  def up
  	add_column :projects, :user_id, :integer
  	add_index :projects, :user_id
  end

  def down
  	remove_index :projects	
  	remove_column :projects, :user_id
  end
end
