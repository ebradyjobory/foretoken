class ProjectApi < ActiveRecord::Base
	
	belongs_to :user

	has_many :forecast_apis
	has_many :future_apis

	validates :project_api_name, :presence => true
end
