class CreateFutures < ActiveRecord::Migration

  def up
    create_table :futures do |t|
    	t.integer :future_year
    	t.integer :project_id

      t.timestamps
    end
  end

  def down
  	drop_table :futures	
  end
end
