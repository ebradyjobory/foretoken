class AddPasswordConfirmationOnUsers < ActiveRecord::Migration

  def up
  	add_column :users, :password_confirmation, :string
  end

  def down
  	remove_column :users, :password_confirmation, :string	
  end
end
