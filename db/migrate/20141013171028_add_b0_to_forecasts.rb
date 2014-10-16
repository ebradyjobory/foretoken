class AddB0ToForecasts < ActiveRecord::Migration
  def change
  	add_column :forecasts, :b0, :integer
  end
end
