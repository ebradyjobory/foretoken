class Future < ActiveRecord::Base
 
	belongs_to :project

	validates :future_year, :presence => true, 
							numericality: { only_integer: true }

	def last_entry_year_time
		project.forecasts.last.time
	end	

	def first_future_year
		project.futures[0]
	end

	def last_entry_year_id
		last_entry = project.forecasts.last
		last_entry_year_id = last_entry.id	
	end

	def timer(i) 
		years_diff = i - project.forecasts.last.year 
		timer = last_entry_year_time + years_diff
	end
		

	def time   
		timer(project.futures.find(id).future_year)	# return a data input	
	end

	def forecasted
		forecasts = project.forecasts
		forecasts.last.b0_all + (forecasts.last.b1_all * time)
	end

end
