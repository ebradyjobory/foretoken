class ForecastController < ApplicationController

	before_action :set_project

  def index
  	@forecasts = @project.forecasts

     sum = 0
     @forecasts.each do |i|
     @revenue = i.revenue
     sum += @revenue
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
     ids << i.id
     end
     ids.each do |k|
     sum += k
     end
     @tbar = sum / ids.length

     # b1 and b0 values
     @b1 = @total_xxbar_ttbar / @total_ttbar_sq
     @b0 = @mean - ( @b1 * @tbar )

     sum_sse = 0
     forecasts = Forecast.all
     forecasts.each do |i|
     sum_sse += i.x_xhatsq
     end
     @sse = sum_sse # SSE

     sum_ssr = 0
     forecasts = Forecast.all
     forecasts.each do |i|
     sum_ssr += i.xhat_xbarsq
     end
     @ssr = sum_ssr # SSR

     sum_sst = 0
     forecasts = Forecast.all
     forecasts.each do |i|
     sum_sst += i.x_xbarsq
     end
     @sst = sum_sst # SST

     # Calculating R^2 ( R^2 = 1 - (SSE / SST))
     @r2 = 1 - (@sse / @sst)
     # @current_project = Project.find(params[:id])
     # @current_forecasts = @current_project.forecasts
     end
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
      redirect_to(:action => 'index', :id => @forecast.id, :project_id => @project.id)
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

  def params_forecast
  	params.require(:forecast).permit(:year, :value)	
  end




end
