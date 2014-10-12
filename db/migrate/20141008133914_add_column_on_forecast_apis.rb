class AddColumnOnForecastApis < ActiveRecord::Migration

  def up
  	add_column :forecast_apis, :country, :string
  	add_column :forecast_apis, :indicator, :string
  	add_column :forecast_apis, :start_date, :integer
  	add_column :forecast_apis, :end_date, :integer
  end

  def down
  	remove_column :forecast_apis, :end_date, :integer
  	remove_column :forecast_apis, :start_date, :integer
  	remove_column :forecast_apis, :indicator, :string
  	remove_column :forecast_apis, :country, :string
  end
end
