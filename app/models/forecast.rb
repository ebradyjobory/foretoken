class Forecast < ActiveRecord::Base

	belongs_to :project

	def input_data
		input_data = Forecast.all
		future_data = Future.all
	end

	def self.total_revenues
		actual_revenues = []
	    forecasted_revenues = []
	    input_data = Forecast.all
	    future_data = Future.all
		input_data.each do |i|
			actual_revenues << i.revenue
		end
		future_data.each do |i|
			forecasted_revenues << i.forcasted
		end
		total_revenues = actual_revenues + forecasted_revenues
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
		revenues = []
		input_data = Forecast.all 
		input_data.each do |i|
			revenues << i.revenue
		end		
		sum = 0
		revenues.each { |i| sum += i }	
		mean = sum / revenues.length

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
		revenues = []
		input_data = Forecast.all
		input_data.each do |i|
			revenues << i.revenue
		end		
		sum = 0
		revenues.each { |i| sum += i }	
		mean = sum / revenues.length
	end

	def xxbar
		revenue.to_f - mean.to_f
	end

	def timer(i)
		input_data = Forecast.all
		input_data.index(i) + 1
	end

	def time
		input_data = Forecast.all
		timer(input_data.find(id))
	end

	def tbar
		sum = 0
		ids = []
		total = 0	
		input_data = Forecast.all	
		input_data.each do |i|
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
		input_data = Forecast.all
		input_data.each do |i|
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
		(revenue - xhat)**2
	end

	def xhat_xbarsq
		(xhat - mean)**2	
	end

	def x_xbarsq
		(revenue - mean)**2	
	end



end
