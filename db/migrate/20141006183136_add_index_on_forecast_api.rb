class AddIndexOnForecastApi < ActiveRecord::Migration
  def up
  	add_index :forecast_apis, :project_api_id
  end

  def down
  	remove_index :forecast_apis, :project_api_id
  end
end
