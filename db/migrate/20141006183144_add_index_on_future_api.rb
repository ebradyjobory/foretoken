class AddIndexOnFutureApi < ActiveRecord::Migration
  def up
  	add_index :future_apis, :project_api_id
  end

  def down
  	remove_index :future_apis, :project_api_id
  end
end
