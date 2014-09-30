class AccessController < ApplicationController

  before_action :confirm_logged_in,  :except => [:login, :attempt_login, :logout]


  def index
    @user = User.find(session[:user_id])
    @projects = @user.projects
    @project = Project.new
  end

  def login
  end

  def attempt_login
  	if params[:email].present? && params[:password].present?
      found_user = User.where(:email => params[:email]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end
    if authorized_user # when authorized user is an object
      session[:user_id] = authorized_user.id
      session[:email] = authorized_user.email
      flash[:notice] = "You are now logged in."
      redirect_to access_index_path(:user_id => session[:user_id])
    else # if authorized_user was false
      flash[:error] = "Invalid username and/or password."
      redirect_to(:action => 'login')
    end	
  end

  def logout
  	session[:user_id] = nil
    session[:email] = nil
    flash[:notice] = "Logged out. Visit us again!"
    redirect_to(:action => "login")	
  end



end
