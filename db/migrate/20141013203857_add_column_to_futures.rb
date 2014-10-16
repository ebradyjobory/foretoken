class AddColumnToFutures < ActiveRecord::Migration
  def change
  	add_column :futures, :forecasted, :integer
  end
end
