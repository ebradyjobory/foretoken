class CreateProjectApis < ActiveRecord::Migration
  def up
    create_table :project_apis do |t|
    	t.string :project_api_name, :limit => 50
        t.timestamps
    end
  end

  def down
  	drop_table :project_apis
  end
end
