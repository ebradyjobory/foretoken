class ProjectsController < ApplicationController
  
	before_action :confirm_logged_in
  before_action :set_user
  # before_action :add_user_email

  def index
  	@projects = Project.all(:user_id => session[:user_id]).includes(:user)
  end

  def new
    @user = User.find(session[:user_id])
  	@project = @user.projects.new
  end

  def create
    @user = User.find(session[:user_id])
    @project = @user.projects.new(project_params)
  	if @project.save
  		#flash[:notice] = "Project was created successfully."
  	  redirect_to(:controller => 'forecasts', :action => 'index', 
                  :user_id => session[:user_id], :project_id => @project.id)
  	else
      #flash[:notice] = "Something's wrong!"
  		render('new')
  	end
  end

  def edit
  	@project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      #flash[:notice] = "Project updated successfully."
      redirect_to(:controller => 'access', :action => 'index', :user_id => session[:user_id])
    else
      render('edit')
    end
  end

  def delete
    @project = Project.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:id]).destroy
    #flash[:notice] = "Project deleted successfully."
    redirect_to(:controller => 'access', :action => 'index', :user_id => session[:user_id])
  end

  private

  def set_user
  	if params[:user_id]
  		@user = User.find(params[:user_id])
  	end	
  end

  def project_params
  	params.require(:project).permit(:name)	
  end



end
