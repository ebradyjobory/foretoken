class AlterProjectApisTable < ActiveRecord::Migration

  def up
  	add_column :project_apis, :user_id, :integer
  end

  def down
  	remove_column :project_apis, :user_id
  end
end
