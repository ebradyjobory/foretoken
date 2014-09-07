class AddIndexOnFutures < ActiveRecord::Migration

  def up
  	add_index :futures, :project_id
  end

  def down
  	remove_inedx :futures
  end
end
