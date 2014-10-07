class SharedController < ApplicationController
	
	before_action :add_user_email
	before_action :set_project

	def index
	   @user = User.find(session[:user_id])
	end


	private

	def set_project
  	if params[:project_id]
  		@project = Project.find(params[:project_id])
  	end	
  end
  
end
