class ProjectController < ApplicationController

	before_action :set_user

  def index
  	@projects = @user.projects
  end

  def new
  	@project = Project.new(:user_id => @user.id)
  end

  def create
  	@project = Project.new(project_params)
  	if @project.save
  		@user.projects << @project
  		flash[:notice] = "Project was created successfully"
  		redirect_to(:controller => 'access', :action => 'index')
  	else
  		render('new')
  	end
  end

  def edit
  	@project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:notice] = "Project updated successfully."
      redirect_to(:controller => 'access', :action => 'index')
    else
      render('edit')
    end
  end

  def delete
    @project = Project.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:id]).destroy
    flash[:notice] = "Project destroyed successfully."
    redirect_to(:controller => 'access', :action => 'index')
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
