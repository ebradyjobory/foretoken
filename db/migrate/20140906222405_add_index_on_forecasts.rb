class AddIndexOnForecasts < ActiveRecord::Migration

  def up
  	add_index :forecasts, :project_id
  end

  def down
  	remove_index :forecasts
  end
end
