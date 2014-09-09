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
     @forecasts.each do |forecast|
      @b1   = forecast.b1
      @tbar = forecast.tbar
      @b0   = forecast.b0
      @r2   = forecast.r2
     end

     # Calculating total years and values for current project
     total_fcast_years = []
     total_future_years = []
     total_fcast_values = []
     total_future_values = []
     values = []
     times = []
     @forecasts.each do |i|
        total_fcast_years << i.year
        total_fcast_values << i.value
        @values = values << i.value
        @times = times << i.time
     end
     @futures.each do |i|
      total_future_years << i.future_year
      total_future_values << i.forecasted
     end
     @total_years = total_fcast_years + total_future_years
     @total_values = total_fcast_values + total_future_values
    end

    # Calculating regression line to be presented on chart
    
    # sum = 0
    # sum2 = 0
    # @values.each { |i| sum += i }  
    # reg_mean = sum / @values.length

    # @times.each do |k|
    #   sum2 += k
    # end 
    # tbar = sum2 / times.length

    # sum3 = 0
    # sum4 = 0
    # @forecasts.each do |i|
    #   sum3 += (i.xxbar_ttbar)
    #   sum4 += (i.ttbar_sq)
    # end
    # b1 = sum3 / sum4
    # b0 = reg_mean  - (b1*tbar)
    regression = []
    @times.each do |time|
      regression <<  @b0 + (@b1 * time)
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
