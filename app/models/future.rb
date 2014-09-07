class Future < ActiveRecord::Base

	belongs_to :project

	def to_be_forcasted
		to_be_forcasted = Future.all
	end

	def self.revenues
		revenues = []
		futures = Future.all
		futures.each do |i|
			revenues << i.forcasted
		end
		revenues	
	end

	def self.future_years
		years = []
		futures = Future.all
		futures.each do |i|
			years << i.future_year
		end
		years	
	end


	def mean
		forecasts = Forecast.all
		revenues = []

		forecasts.each do |i|
			revenues << i.revenue
		end		
		
		sum = 0
		revenues.each { |i| sum += i }	
		mean = sum / revenues.length
	end

	def tbar
		sum = 0
		ids = []
		total = 0
		forecasts = Forecast.all		
		forecasts.each do |i|
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
		forecasts = Forecast.all
		forecasts.each do |i|
			sum1 += (i.xxbar_ttbar)
			sum2 += (i.ttbar_sq)
		end
		sum1 / sum2
	end

	def b0
		mean  - (b1 * tbar)
	end


	def last_entry_year
		forecasts = Forecast.all
		last_entry = forecasts.last
		last_entry_year = last_entry.year
	end	

	def last_entry_year_id
		forecasts = Forecast.all
		last_entry = forecasts.last
		last_entry_year_id = last_entry.id	
	end

	def timer(i)
		forecasts = Forecast.all
		last_entry = forecasts.last
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

	def forcasted
		b0 + (b1 * time)
	end

	
end
