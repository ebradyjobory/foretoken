class AddIndexOnProjectApi < ActiveRecord::Migration

  def up
  	add_index :project_apis, :user_id
  end

  def down
  	remove_index :project_apis, :user_id
  end
end
