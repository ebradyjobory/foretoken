class Mean < ActiveRecord::Base
	has_many :forecasts


	# def mean_value
	# 	project = Project.find(params[:project_id])
	# 	forecasts = project.forecasts
	# 	values = []
	# 	forecasts.each do |i|
	# 		values << i.value
	# 	end		
	# 	sum = 0
	# 	values.each { |i| sum += i }	
	# 	mean = sum.to_f / values.length	
	# end
end
