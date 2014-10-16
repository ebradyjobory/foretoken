class AddColumnOnForecasts < ActiveRecord::Migration
  def up
  	add_column :forecasts, :mean_id, :integer
  end

  def down
  	remove_column :forecasts, :mean_id, :integer
  end
end
