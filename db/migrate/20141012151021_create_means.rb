class CreateMeans < ActiveRecord::Migration
  def change
    create_table :means do |t|
    	t.integer :mean

      t.timestamps
    end
  end
end
