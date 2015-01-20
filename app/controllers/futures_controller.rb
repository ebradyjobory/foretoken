class FuturesController < ApplicationController
  
  respond_to :html, :json
  before_action :confirm_logged_in
  before_action :set_project

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
    @forecasts = @project.forecasts

    if @future.save
      flash[:notice] = "Future was created successfully"
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
    if @future.update_attributes(params_future)
      flash[:notice] = "Future updated successfully."
    respond_with @forecast
    else
      render('edit')
    end
  end

  def destroy
    @future = Future.find(params[:id])
    @future.destroy
    flash[:notice] = "Future data deleted successfully."  
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