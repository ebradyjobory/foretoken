class AccessController < ApplicationController

  before_action :confirm_logged_in,  :except => [:login, :attempt_login, :logout]
  #before_action :add_user_email, :only => [:index]

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
      redirect_to access_index_path(:user_id => session[:user_id])
    else # if authorized_user was false
      flash[:error] = "Invalid username and/or password."
      redirect_to access_login_path
    end	
  end

  def logout
  	session[:user_id] = nil
    session[:email] = nil
    redirect_to root_path	
  end

end
