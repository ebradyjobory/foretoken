class AddMeanToFuturesTable < ActiveRecord::Migration

  def up
  	add_column :futures, :mean, :integer
  end

  def down
  	remove_column :futures, :mean, :integer
  end
end
