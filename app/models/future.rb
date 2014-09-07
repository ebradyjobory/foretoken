class Future < ActiveRecord::Base

	belongs_to :project

	def to_be_forcasted
	    Future.where(:project_id => project.id)
	end

	def project_forecast
		@forecast_data = Forecast.where(:project_id => project_id)	
	end

	# def self.values
	# 	values = []
	# 	to_be_forcasted.each do |i|
	# 		values << i.forcasted
	# 	end
	# 	values	
	# end

	# def self.future_years
	# 	years = []
	# 	to_be_forcasted.each do |i|
	# 		years << i.future_year
	# 	end
	# 	years	
	# end

	def mean
		values = []
		project_forecast.each do |i|
			values << i.value
		end		
		sum = 0
		values.each { |i| sum += i }	
		mean = sum / values.length
	end

	def tbar
		sum = 0
		ids = []
		total = 0
		project_forecast.each do |i|
			ids << i.id
		end
		ids.each do |k|
			sum += k
		end	
		tbar = sum / ids.length
	end

	def b1
		sum1 = 0
		sum2 = 0
		project_forecast.each do |i|
			sum1 += (i.xxbar_ttbar)
			sum2 += (i.ttbar_sq)
		end
		sum1 / sum2
	end

	def b0
		mean  - (b1 * tbar)
	end


	def last_entry_year
		last_entry = project_forecast.last
		last_entry_year = last_entry.year
	end	

	def last_entry_year_id
		last_entry = project_forecast.last
		last_entry_year_id = last_entry.id	
	end

	def timer(i)
		last_entry = project_forecast.last
		time_on_last_item = last_entry.time
		timer = to_be_forcasted.index(i) + 1 + time_on_last_item
	end
		

	def time
		timer(to_be_forcasted.find(id))
			# futures = Future.all
			# years_diff = future_year - last_entry_year
			# id = last_entry_year_id + years_diff
			# time = id
	end

	def forecasted
		b0 + (b1 * time)
	end

	
end
