class AccessController < ApplicationController

  before_action :confirm_logged_in,  :except => [:login, :attempt_login, :logout]


  def index
  	@users = User.all
    @users.each do |user|
    	@current_user = user if user.profile_name == session[:profile_name] 
	end
  end

  def login
  end

  def attempt_login
  	if params[:profile_name].present? && params[:password].present?
      found_user = User.where(:profile_name => params[:profile_name]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end
    if authorized_user # when authorized user is an object
      session[:user_id] = authorized_user.id
      session[:profile_name] = authorized_user.profile_name
      flash[:notice] = "You are now logged in."
      redirect_to(:action => 'index')
    else # if authorized_user was false
      flash[:notice] = "Invalid profile name/password."
      redirect_to(:action => 'login')
    end	
  end

  def logout
  	session[:user_id] = nil
    session[:profile_name] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")	
  end



  private

  def confirm_logged_in
  	unless session[:user_id]
  		flash[:notice] = "Please log in."
  		redirect_to(:action => 'login')
  		return false
  	else
  		return true
  	end	
  end


end
