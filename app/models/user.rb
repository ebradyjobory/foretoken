class User < ActiveRecord::Base
	has_secure_password
	 
	has_many :projects


	def name
		first_name + ' ' + last_name	
	end
end
