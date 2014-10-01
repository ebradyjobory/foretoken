class ForecastsController < ApplicationController

  respond_to :html, :json

  before_action :confirm_logged_in
	before_action :set_project
  before_action :check_value, :only => [:index]

  def index
    @forecasts = @project.forecasts
    @futures = @project.futures
    @current_user = @project.user
    @forecast = Forecast.new
    @future = Future.new

    total_fcast_years = []
    total_future_years = []
    total_fcast_values = []
    total_future_values = []
    values = []
    times = []
    @forecasts.each do |forecast|
      total_fcast_years << forecast.year
      total_fcast_values << forecast.value
      @values = values << forecast.value
      @times = times << forecast.time
      @b1   = forecast.b1
      @tbar = forecast.tbar
      @b0   = forecast.b0
    end
    # Calculating total years and values for current project
    #  total_fcast_years = []
    #  total_future_years = []
    #  total_fcast_values = []
    #  total_future_values = []
    #  values = []
    #  times = []
    #  @project.forecasts.each do |i|
    #     total_fcast_years << i.year
    #     total_fcast_values << i.value
    #     @values = values << i.value
    #     @times = times << i.time
    #  end
    @futures.each do |i|
      total_future_years << i.future_year
      total_future_values << i.forecasted
    end
    @total_years = total_fcast_years + total_future_years
    @total_values = total_fcast_values + total_future_values

    # Calculating regression line to be presented on chart
    regression = []
    @times.each do |time|
      regression <<  @b0 + (@b1 * time)
    end
    @regression = regression

  end

  def new
    @project = Project.find(params[:project_id])
    @forecast = @project.forecasts.new
  end

  def create
    @project = Project.find(params[:project_id])
    @forecast = @project.forecasts.new(params_forecast)
  	if @forecast.save
  		flash[:notice] = "Data was created successfully"
          # if @project.forecasts.size == 1   
          #     redirect_to(:action => 'index')
          # end
  	else
       flash[:error] = "Opps. Something's wrong!"
  		 # render('new')
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
      flash[:notice] = "Data was updated successfully."
      # @forecasts = @project.forecasts
      # @current_user = @project.user

      respond_with @forecast
      # redirect_to user_project_forecasts_path(@forecast.project.user.id, @forecast.project.id)
    else
      # render('edit')
    end
  end

  # def delete
  #   @forecast = Forecast.find(params[:id])
  # end

  def destroy
    @forecast = Forecast.find(params[:id])
    # respond_to do |format|
    @forecast.destroy
    flash[:notice] = "Data deleted successfully."
    #     format.html { redirect_to user_project_forecasts_path(:user_id => session[:user_id],  
    #                                           :project_id => @project.id)}
    #     format.json { head :no_content }
    #     format.js   { render :layout => false }
    #   else
    # # redirect_to(:action => 'index', :project_id => @project.id)
    #   end
    end


  private

  def set_project
  	if params[:project_id]
  		@project = Project.find(params[:project_id])
  	end	
  end

  def check_value
    if @project.forecasts.empty?
      @times = [1, 1]
      @b1 = 1
      @b0 = 1
      # redirect_to(:action => 'new', :project_id => @project.id)
    end
  end

  def params_forecast
  	params.require(:forecast).permit(:year, :value)	
  end



end
