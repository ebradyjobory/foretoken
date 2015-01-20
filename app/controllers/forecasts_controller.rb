class ForecastsController < ApplicationController

  respond_to :html, :json

  before_action :confirm_logged_in
  before_action :set_project
  before_action :add_user_email

  def index

    @forecasts = @project.forecasts
    @futures = @project.futures
    @current_user = @project.user
    @forecast = Forecast.new
    @future = Future.new
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
     end
    @futures.each do |i|
      total_future_years << i.future_year
      total_future_values << i.forecasted
    end
    @total_years = total_fcast_years + total_future_years
    @total_values = total_fcast_values + total_future_values
    @forecasted = total_future_values
    @future_years = total_future_years

    # Calculating regression line to be presented on chart
    @regression = []
    @forecasts.each do |forecast|
      @regression <<  (forecast.b0_all + (forecast.b1_all * (@forecasts.index(forecast) + 1)))
    end
  end

  def new
    @project = Project.find(params[:project_id])
    @forecast = @project.forecasts.new
  end

  def create
    @project = Project.find(params[:project_id])
    @forecast = @project.forecasts.new(params_forecast)
    @forecast.time = @project.forecasts.index(@forecast) + 1
    if @forecast.save
    else
    end
  end

  def edit
    @forecast = Forecast.find(params[:id])
    @forecasts = @project.forecasts
    @current_user = @project.user
  end

  def update
    @forecast = Forecast.find(params[:id])
    if @forecast.update_attributes(params_forecast)
      respond_with @forecast
    else
    end
  end

  def destroy
    @forecast = Forecast.find(params[:id])
    @forecast.destroy
  end


  private

  def set_project
    if params[:project_id]
      @project = Project.find(params[:project_id])
    end 
  end

  def params_forecast
    params.require(:forecast).permit(:year, :value) 
  end
  

end