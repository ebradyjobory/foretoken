class FutureApisController < ApplicationController

  respond_to :html, :json
  before_action :confirm_logged_in
  # before_action :add_user_email
  before_action :set_project
  # before_action :check_forecast_value, :only => [:index]

  def index
  	@future_apis = @project.future_apis
    @future_api = @project.future_apis.new
    @current_user = @project.user

  end

  def new
    @project = Project.find(params[:project_id])
  	@future_api = @project.future_apis.new
  end

  def create
  	@project = Project.find(params[:project_id])
    @future_api = @project.future_apis.new(params_future)
  	if @future_api.save
  		flash[:notice] = "Future was created successfully"
  		# redirect_to user_project_forecasts_path(:user_id => session[:user_id],  
                                              # :project_id => @project.id)
  	else
     flash[:error] = "Opps. Something's wrong!"
  	end
  end

  def edit
  	@future_api = FutureApi.find(params[:id])
    @current_user = @project.user
  end

  def update
    @future_api = FutureApi.find(params[:id])
    # @current_user = @project.user

    if @future_api.update_attributes(params_future)
      flash[:notice] = "Future updated successfully."
      # redirect_to user_project_forecasts_path(:user_id => session[:user_id],     
                                        # :project_id => @project.id)
    respond_with @forecast_api
    else
      render('edit')
    end
  end

  # def delete
  #   @project = Project.find(params[:project_id])
  #   @future = @project.futures.find(params[:id])
  # end

  def destroy
    @future_api = FutureApi.find(params[:id])
    @future_api.destroy
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
  	params.require(:future).permit(:future_api_year)	
  end


end

