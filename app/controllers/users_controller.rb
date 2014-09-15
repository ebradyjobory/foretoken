class UsersController < ApplicationController

  before_action :confirm_logged_in, :except => [:new, :create]

  def index
    @users = User.all.includes(:projects)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params_user)
    if @user.save
      flash[:notice] = "User was created successfully"
      redirect_to(:controller => 'access', :action => 'index', :user_id => @user.id)
    else
      render('new')
    end   
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params_user)
      flash[:notice] = "User information was updated successfully"
      redirect_to(:controller => 'access', :action => 'index')
    else
      render('edit')
    end
  end

  def delete
  end

  private

  def params_user
    params.require(:user).permit(:first_name, :last_name, :profile_name,
                                 :email, :password, :password_confirmation)
    
  end



end
