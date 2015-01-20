class Forecast < ActiveRecord::Base

	belongs_to :project

	validates :year, :presence => true, :numericality => { only_integer: true }
	validates :value, :presence => true, :numericality => { only_integer: true }

	def mean_all
		# Mean of values in forecasts table
		values = []
		project.forecasts.each do |i|
			values << i.value
		end		
		sum = 0
		values.each { |i| sum += i }	
		mean = sum.to_f / values.length
	end

	def tbar_all
		sum = 0
		times = []
		project.forecasts.each do |i|
			times << i.time
		end
		times.each { |i| sum += i }	
		mean = sum.to_f / times.length
	end

	def ttbar_all
		time - tbar_all
	end

	def ttbar_sq_all 
		 (ttbar_all)**2
	end

	def xxbar_ttbar_all
		(value - mean_all)*(time - tbar_all)
	end
	def b1_all
		sum = 0
		sum2 = 0
		project.forecasts.each do |i|
			sum += i.xxbar_ttbar_all
			sum2 += i.ttbar_sq_all
		end
		sum / sum2
	end

	def b0_all
		 mean_all - (b1_all * tbar_all)
	end
end