module Regression

	def mean
		values = []
		project_forecast.each do |i|
			values << i.value
		end		
		sum = 0
		values.each { |i| sum += i }	
		mean = sum.to_f / values.length
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
	
end