class CreateForecasts < ActiveRecord::Migration

  def up
    create_table :forecasts do |t|
    	t.integer :year
    	t.integer :value
    	t.integer :project_id

      t.timestamps
    end
  end

  def down
  	drop_table :forecasts
  end
end
