class AddColumnOnUsers < ActiveRecord::Migration

  def up
  	add_column :users, :project_api_id, :integer
  end

  def down
  	remove_column :users, :project_api_id
  end
end
