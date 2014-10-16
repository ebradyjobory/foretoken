class AddColumnOnMean < ActiveRecord::Migration
  def up
  	add_column :means, :forecast_id, :integer
  end

  def down
  	remove_column :means, :forecast_id, :integer
  end
end
