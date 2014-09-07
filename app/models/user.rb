class User < ActiveRecord::Base
	
	has_secure_password
	 
	has_many :projects

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :profile_name, presence: true, :uniqueness => true
	validates :password, presence: true
	validates :email, :presence => true,
                    :length => { :maximum => 100 },
                    :format => EMAIL_REGEX,
                    :confirmation => true


	def name
		first_name + ' ' + last_name	
	end
	
end
