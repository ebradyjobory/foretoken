class Project < ActiveRecord::Base

	belongs_to :user
	has_many :forecasts
	has_many :futures
end
