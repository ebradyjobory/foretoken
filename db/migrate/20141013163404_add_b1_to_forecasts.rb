class AddB1ToForecasts < ActiveRecord::Migration
  def up
  	add_column :forecasts, :b1, :integer
  end

  def down
  	remove_column :forecasts, :b1, :integer
  end
end
