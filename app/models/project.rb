class Project < ActiveRecord::Base

	belongs_to :user
	has_many :forecasts
	has_many :futures

	def current_project
		current_project = Project.where(:id => :project_id)
		
	end


end
