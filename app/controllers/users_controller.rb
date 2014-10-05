class UsersController < ApplicationController

  before_action :confirm_logged_in, :except => [:new, :create]
  # before_action :add_user_email, :only => [:index, :edit, :update]

  def index
    @users = User.all.includes(:projects)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params_user)
    if @user.save
      NotificationMailer.sign_up_notification(@user).deliver
      session[:user_id] = @user.id
      redirect_to access_index_path
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

  def destroy
    @user = User.find(params[:id])
    # respond_to do |format|
    @user.destroy
    NotificationMailer.terminate_notification(@user).deliver
    session[:user_id] = nil
    session[:email] = nil
    redirect_to root_path
    end

  private

  def params_user
    params.require(:user).permit(:first_name, :last_name, :profile_name,
                                 :email, :password, :password_confirmation)
    
  end



end
