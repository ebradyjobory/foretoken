class FutureApisController < ApplicationController

  respond_to :html, :json
  before_action :confirm_logged_in
  before_action :set_project

  def index
  	@future_apis = @project_api.future_apis
    @future_api = @project_api.future_apis.new
    @current_user = @project_api.user
  end

  def new
    @project_api = ProjectApi.find(params[:project_api_id])
  	@future_api = @project_api.future_apis.new
  end

  def create
  	@project_api = ProjectApi.find(params[:project_api_id])
    @future_api = @project_api.future_apis.new(params_future)
  	if @future_api.save
  		flash[:notice] = "Future was created successfully"
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
    if @future_api.update_attributes(params_future)
      flash[:notice] = "Future updated successfully."
    respond_with @forecast_api
    else
      render('edit')
    end
  end

  def destroy
    @future_api = FutureApi.find(params[:id])
    @future_api.destroy
    flash[:notice] = "Future data deleted successfully."
  end


  private

  def set_project
  	if params[:project_api_id]
  		@project_api = ProjectApi.find(params[:project_api_id])
  	end	
  end

  def params_future
  	params.require(:future_api).permit(:future_api_year)	
  end

end

