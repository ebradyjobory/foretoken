class AddColumnToForecasts < ActiveRecord::Migration

  def up
  	add_column :forecasts, :mean, :integer
  end

  def down
  	remove_column :forecasts, :mean, :integer
  end
end
