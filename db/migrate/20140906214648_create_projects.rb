class CreateProjects < ActiveRecord::Migration

  def up
    create_table :projects do |t|
    	t.string :name, :limit => 50
    	t.integer :forecast_id
        t.timestamps
    end
  end

  def down
  	drop_table :projects	
  end
end
