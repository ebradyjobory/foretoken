class UserController < ApplicationController

  before_action :confirm_logged_in, :except => [:new, :create]

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params_user)
    if @user.save
      flash[:notice] = "User was created successfully"
      redirect_to(:controller => 'access', :action => 'index')
    else
      render('new')
    end   
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

  def params_user
    params.require(:user).permit(:first_name, :last_name, :profile_name,
                                 :email, :password)
    
  end



end
