class ProjectApisController < ApplicationController
  
  before_action :confirm_logged_in
  before_action :set_user
  # before_action :add_user_email

  def index
  	@project_apis = ProjectApi.all(:user_id => session[:user_id]).includes(:user)
  end

  def new
    @user = User.find(session[:user_id])
  	@project_api = @user.project_apis.new
  end

  def create
    @user = User.find(session[:user_id])
    @project_api = @user.project_apis.new(project_params)
  	if @project_api.save
  		flash[:notice] = "Project was created successfully."
      # redirect_to shared_index_path(:user_id => session[:user_id], :project_id => @project.id)
  	  redirect_to(:controller => 'forecast_apis', :action => 'index', 
                   :user_id => session[:user_id], :project_api_id => @project_api.id)
  	else
  		render('new')
  	end
  end

  def edit
  	@project_api = ProjectApi.find(params[:id])
  end

  def update
    @project_api = ProjectApi.find(params[:id])
    if @project_api.update_attributes(project_api_aprams)
      flash[:notice] = "Project updated successfully."
      redirect_to(:controller => 'access', :action => 'index', :user_id => session[:user_id])
    else
      render('edit')
    end
  end

  def delete
    @project_api = ProjectApi.find(params[:id])
  end

  def destroy
    @project_api = ProjectApi.find(params[:id]).destroy
    flash[:notice] = "Project deleted successfully."
    redirect_to(:controller => 'access', :action => 'index', :user_id => session[:user_id])
  end

  private

  def set_user
  	if params[:user_id]
  		@user = User.find(params[:user_id])
  	end	
  end

  def project_params
  	params.require(:project_api).permit(:project_api_name)	
  end



end

