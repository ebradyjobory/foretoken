class ForecastApi < ActiveRecord::Base
	belongs_to :project_api

	def project_forecast
	    project_api.forecast_apis	
	end
	def to_be_forcasted
	    project_api.future_apis
	end

	def mean
		values = []
		project_forecast.each do |i|
			values << i.forecast_api_value
		end		
		sum = 0
		values.each { |i| sum += i }	
		mean = sum.to_f / values.length
	end

	def xxbar
		(forecast_api_value - mean).to_f
	end

	def timer(i)
		project_forecast.index(i) + 1
	end

	def time
		timer(project_forecast.find(id))
	end

	def tbar
		sum = 0
		times = []
		project_forecast.each do |i|
			times << i.time
		end
		times.each do |k|
			sum += k
		end	
		tbar = sum / times.length
	end

	def ttbar
		time - tbar
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
		b0 = mean - (b1*tbar)
	end

end