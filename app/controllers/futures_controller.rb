class FuturesController < ApplicationController
  
  respond_to :html, :json
	before_action :confirm_logged_in
  # before_action :add_user_email
  before_action :set_project
  # before_action :check_forecast_value, :only => [:index]

  def index
  	@futures = @project.futures
    @future = @project.futures.new
    @current_user = @project.user

  end

  def new
    @project = Project.find(params[:project_id])
  	@future = @project.futures.new
  end

  def create
  	@project = Project.find(params[:project_id])
    @future = @project.futures.new(params_future)
  	if @future.save
  		flash[:notice] = "Future was created successfully"
  		# redirect_to user_project_forecasts_path(:user_id => session[:user_id],  
                                              # :project_id => @project.id)
  	else
     flash[:error] = "Opps. Something's wrong!"
  	end
  end

  def edit
  	@future = Future.find(params[:id])
    @current_user = @project.user
  end

  def update
    @future = Future.find(params[:id])
    # @current_user = @project.user

    if @future.update_attributes(params_future)
      flash[:notice] = "Future updated successfully."
      # redirect_to user_project_forecasts_path(:user_id => session[:user_id],     
                                        # :project_id => @project.id)
    respond_with @forecast
    else
      render('edit')
    end
  end

  # def delete
  #   @project = Project.find(params[:project_id])
  #   @future = @project.futures.find(params[:id])
  # end

  def destroy
    @future = Future.find(params[:id])
    @future.destroy
    flash[:notice] = "Future data deleted successfully."
    # redirect_to user_project_forecasts_path(:user_id => session[:user_id],  
                                              # :project_id => @project.id)  
  end


  private

  def set_project
  	if params[:project_id]
  		@project = Project.find(params[:project_id])
  	end	
  end

  def params_future
  	params.require(:future).permit(:future_year)	
  end


end
