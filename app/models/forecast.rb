class Forecast < ActiveRecord::Base

	belongs_to :project

	validates :year, :presence => true
	validates :value, :presence => true
	
	def project_forecast
		@forecast_data = project.forecasts	
	end
	def to_be_forcasted
	    project.futures
	end

	# def project_future
	# 	@future_data = project.future
	# end

	def mean
		values = []
		project_forecast.each do |i|
			values << i.value
		end		
		sum = 0
		values.each { |i| sum += i }	
		mean = sum.to_f / values.length
	end

	def xxbar
		(value - mean).to_f
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

	# def xhat
	#     b0 + (b1 * time)
	# end

	# def x_xhatsq
	# 	(value - xhat)**2
	# end

	# def xhat_xbarsq
	# 	(xhat - mean)**2	
	# end

	# def x_xbarsq
	# 	(value - mean)**2	
	# end


	#calculating R^2
	# def sse
	#  sum_sse = 0
 #     project_forecast.each do |i|
 #     sum_sse += i.x_xhatsq
 #     end
 #     @sse = sum_sse # SSE	
	# end
	
	# def ssr
	#  sum_ssr = 0
 #     project_forecast.each do |i|
 #     sum_ssr += i.xhat_xbarsq
 #     end
 #     @ssr = sum_ssr # SSR
	# end

	# def sst
	#  sum_sst = 0
 #     project_forecast.each do |i|
 #     sum_sst += i.x_xbarsq
 #     end
 #     @sst = sum_sst # SST 	
	# end 
     
    # def r2
    #   # Calculating R^2 ( R^2 = 1 - (SSE / SST))
    #   1 - (sse / sst)	
    # end 


    

end
