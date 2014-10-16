class AddColumnsToForecasts < ActiveRecord::Migration

  def change
  	add_column :forecasts, :time, :integer
  	add_column :forecasts, :tbar, :integer
  	add_column :forecasts, :ttbar, :integer
  	add_column :forecasts, :xxbar_ttbar, :integer
  	add_column :forecasts, :ttbar_sq, :integer
  end
end
