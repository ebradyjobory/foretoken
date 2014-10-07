class CreateForecastApis < ActiveRecord::Migration
  def up
    create_table :forecast_apis do |t|
    	t.integer :forecast_api_year
    	t.integer :forecast_api_value
    	t.integer :project_api_id
      t.timestamps
    end
  end

  def down
  	drop_table :forecast_apis
  end
end
