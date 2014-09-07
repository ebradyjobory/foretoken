class FutureController < ApplicationController

	before_action :confirm_logged_in
  before_action :set_project

  def index
  	@futures = @project.futures
  end

  def new
  	@future = Future.new(:project_id => @project.id)
  end

  def create
  	@future = Future.new(params_future)
  	if @future.save
  		@project.futures << @future
  		flash[:notice] = "Future was created successfully"
  		redirect_to(:controller => 'forecast', :action => 'index', :project_id => @project.id)
  	else
  		render('new')
  	end
  end

  def edit
  	@future = Future.find(params[:id])
  end

  def update
    @future = Future.find(params[:id])
    if @future.update_attributes(params_future)
      flash[:notice] = "Future updated successfully."
      redirect_to(:controller => 'forecast', :action => 'index', :id => @future.id, :project_id => @project.id)
    else
      render('edit')
    end
  end

  def delete
    @future = Future.find(params[:id])
  end

  def destroy
    future = Future.find(params[:id]).destroy
    flash[:notice] = "Future destroyed successfully."
    redirect_to(:controller => 'forecast', :action => 'index', :project_id => @project.id)
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
