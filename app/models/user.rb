class User < ActiveRecord::Base
	
	has_secure_password
	 
	has_many :projects
	has_many :project_apis

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

	validates :password, presence: true
	validates :password_confirmation, presence: true
	validates :email, :presence => true, 
                    :length => { :maximum => 100 },
                    :format => EMAIL_REGEX,
                    :confirmation => true,
                    :uniqueness => true
	
end
