class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private


  def confirm_logged_in
  	unless session[:user_id]
  		flash[:notice] = "Please log in."
  		redirect_to access_login_path
  		return false
  	else
  		return true
  	end	
  end

  def current_user
    users = User.all
    users.each do |user|
    @current_user = user if user.id == session[:user_id] 
   end
  end

  def add_user_email
    @user = User.find(session[:user_id])
  end

  


  
end
