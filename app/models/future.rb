class Future < ActiveRecord::Base
 
	belongs_to :project

	validates :future_year, :presence => true, 
							numericality: { only_integer: true }

	# def mean
	# 	values = []
	# 	project_forecast.each do |i|
	# 		values << i.value
	# 	end		
	# 	sum = 0
	# 	values.each { |i| sum += i }	
	# 	mean = sum.to_f / values.length
	# end

	# def tbar
	# 	sum = 0
	# 	ids = []
	# 	total = 0
	# 	project_forecast.each do |i|
	# 		ids << i.time
	# 	end
	# 	ids.each do |k|
	# 		sum += k
	# 	end	
	# 	tbar = sum / ids.length
	# end

	# def b1
	# 	sum1 = 0
	# 	sum2 = 0
	# 	project_forecast.each do |i|
	# 		sum1 += (i.xxbar_ttbar)
	# 		sum2 += (i.ttbar_sq)
	# 	end
	# 	sum1 / sum2
	# end

	# def b0
	# 	project.forecasts.first.mean  - (project.forecasts.first.b1 * 10)
	# end


	def last_entry_year_time
		project.forecasts.last.time
	end	

	def first_future_year
		project.futures[0]
		# future_years = []
		# to_be_forcasted.each do |i|
			# future_years << i.future_year
		# end
		# future_years[0]
	end

	def last_entry_year_id
		last_entry = project.forecasts.last
		last_entry_year_id = last_entry.id	
	end

	def timer(i) # i = ex. 1877
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
