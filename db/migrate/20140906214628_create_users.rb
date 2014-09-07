class CreateUsers < ActiveRecord::Migration

  def up
    create_table :users do |t|
    	t.string :first_name, :limit => 50
    	t.string :last_name, :limit => 50
    	t.string :profile_name, :limit => 25
    	t.string :email
    	t.string :password_digest
    	t.string :project_id
      	t.timestamps
    end
  end

  def down
  	drop_table :users 	
  end
end
