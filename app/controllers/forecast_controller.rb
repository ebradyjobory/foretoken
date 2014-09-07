class ForecastController < ApplicationController

  before_action :confirm_logged_in
	before_action :set_project
  before_action :check_value, :only => [:index]

  def index
  	@forecasts = @project.forecasts
    @futures = @project.futures

    if @forecasts.empty?
      render(:controller => 'forecast', :action => 'new',
             :project => @project.id)
    else
     sum = 0
     @forecasts.each do |i|
     @value = i.value
     sum += @value
     end
     @mean = sum / @forecasts.length # mean

     total_ttbarsq = 0
     total_xxbar_ttbar = 0
     @forecasts.each do |k|
     total_ttbarsq += k.ttbar_sq
     total_xxbar_ttbar += k.xxbar_ttbar
     end
     @total_ttbar_sq = total_ttbarsq
     @total_xxbar_ttbar = total_xxbar_ttbar

     sum = 0
     ids = []
     total_tbar = 0
     @forecasts.each do |i|
     ids << i.time
     end
     ids.each do |k|
     sum += k
     end
     @tbar = sum / ids.length

     # b1 and b0 values
     @b1 = @total_xxbar_ttbar / @total_ttbar_sq
     @b0 = @mean - ( @b1 * @tbar )

     sum_sse = 0
     @forecasts.each do |i|
     sum_sse += i.x_xhatsq
     end
     @sse = sum_sse # SSE

     sum_ssr = 0
     @forecasts.each do |i|
     sum_ssr += i.xhat_xbarsq
     end
     @ssr = sum_ssr # SSR

     sum_sst = 0
     @forecasts.each do |i|
     sum_sst += i.x_xbarsq
     end
     @sst = sum_sst # SST

     # Calculating R^2 ( R^2 = 1 - (SSE / SST))
     @r2 = 1 - (@sse / @sst)
     

     # Calculating total years and values for current project
     total_fcast_years = []
     total_future_years = []
     total_fcast_values = []
     total_future_values = []
     @forecasts.each do |i|
        total_fcast_years << i.year
        total_fcast_values << i.value
     end
     @futures.each do |i|
      total_future_years << i.future_year
      total_future_values << i.forecasted
     end
     @total_years = total_fcast_years + total_future_years
     @total_values = total_fcast_values + total_future_values
    end

    # Calculating regression line to be presented on chart
    values = []
    @forecasts.each do |i|
      values << i.value
    end   
    sum = 0
    values.each { |i| sum += i }  
    reg_mean = sum / values.length

    sum2 = 0
    times = []
    total = 0   
    @forecasts.each do |i|
      times << i.time
    end
    times.each do |k|
      sum2 += k
    end 
    tbar = sum2 / times.length

    sum3 = 0
    sum4 = 0
    @forecasts.each do |i|
      sum3 += (i.xxbar_ttbar)
      sum4 += (i.ttbar_sq)
    end
    b1 = sum3 / sum4
    b0 = reg_mean  - (b1*tbar)
    regression = []
    t = 1
    while t <= @forecasts.size
      regression <<  b0 + (b1*t)
      t += 1
    end
    @regression = regression  

  end

  def new
  	@forecast = Forecast.new(:project_id => @project.id)
  end

  def create
  	@forecast = Forecast.new(params_forecast)
  	if @forecast.save
  		@project.forecasts << @forecast
  		flash[:notice] = "Forecast was created successfully"
  		redirect_to(:action => 'index', :project_id => @project.id)
  	else
  		render('new')
  	end
  end

  def edit
  	@forecast = Forecast.find(params[:id])
  end

  def update
    @forecast = Forecast.find(params[:id])
    if @forecast.update_attributes(params_forecast)
      flash[:notice] = "Forecast updated successfully."
      redirect_to(:action => 'index', :id => @forecast.id, 
                  :project_id => @project.id)
    else
      render('edit')
    end
  end

  def delete
    @forecast = Forecast.find(params[:id])
  end

  def destroy
    forecast = Forecast.find(params[:id]).destroy
    flash[:notice] = "Forecast destroyed successfully."
    redirect_to(:action => 'index', :project_id => @project.id)
  end

  private

  def set_project
  	if params[:project_id]
  		@project = Project.find(params[:project_id])
  	end	
  end

  def check_value
    if @project.forecasts.empty?
      redirect_to(:action => 'new', :project_id => @project.id)
    end
  end

  def params_forecast
  	params.require(:forecast).permit(:year, :value)	
  end



end
