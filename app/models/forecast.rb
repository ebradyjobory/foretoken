class Forecast < ActiveRecord::Base

	belongs_to :project

	def project_forecast
		@forecast_data = Forecast.where(:project_id => project_id)	
	end

	def project_future
		@future_data = Future.where(:project_id => project_id)
	end

	def self.total_values
		actual_values = []
	    forecasted_values = []
	    input_data = Forecast.all
	    future_data = Future.all
		input_data.each do |i|
			actual_values << i.value
		end
		future_data.each do |i|
			forecasted_values << i.forecasted
		end
		total_values = actual_values + forecasted_values
	end

	def self.total_years
		years = []
		future_years = []
		input_data = Forecast.all
		input_data.each do |i|
			years << i.year
		end
		futures = Future.all
		futures.each do |j|
			future_years << j.future_year
		end
		total_years = years + future_years
	end

	def self.regression
		values = []
		input_data = Forecast.all 
		input_data.each do |i|
			values << i.value
		end		
		sum = 0
		values.each { |i| sum += i }	
		mean = sum / values.length

		sum2 = 0
		ids = []
		total = 0		
		input_data.each do |i|
			ids << i.id
		end
		ids.each do |k|
			sum2 += k
		end	
		tbar = sum2 / ids.length

		sum3 = 0
		sum4 = 0
		input_data.each do |i|
			sum3 += (i.xxbar_ttbar)
			sum4 += (i.ttbar_sq)
		end
		b1 = sum3 / sum4
		b0 = mean  - (b1*tbar)
		regression = []
		t = 1
		while t <= input_data.size
			regression <<  b0 + (b1*t)
			t += 1
		end
		regression	
	end



	def mean
		values = []
		project_forecast.each do |i|
			values << i.value
		end		
		sum = 0
		values.each { |i| sum += i }	
		mean = sum / values.length
	end

	def xxbar
		value.to_f - mean.to_f
	end

	def timer(i)
		project_forecast.index(i) + 1
	end

	def time
		timer(project_forecast.find(id))
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

	def ttbar
		id - tbar
	end

	def xxbar_ttbar
		xxbar * ttbar
	end

	def ttbar_sq
		(ttbar.abs)**2	
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
		b0 = mean  - (b1*tbar)
	end

	def xhat
	    b0 + (b1 * time)
	end

	def x_xhatsq
		(value - xhat)**2
	end

	def xhat_xbarsq
		(xhat - mean)**2	
	end

	def x_xbarsq
		(value - mean)**2	
	end



end
