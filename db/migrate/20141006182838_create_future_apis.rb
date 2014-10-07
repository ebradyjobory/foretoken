class CreateFutureApis < ActiveRecord::Migration
  def change
    create_table :future_apis do |t|
    	t.integer :future_api_year
    	t.integer :project_api_id
      t.timestamps
    end
  end
end
