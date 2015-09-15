class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @lists = @user.lists.paginate(page: params[:page])
    #redirect_to root_url
  end

  def new
    if @user
      redirect_to root_url
    else
      # Temporarily disable user registration, until permissions/ACLs are
      # implemented. ngm, 2013-09-22 (Autumnal Equinox!!)
      #@user = User.new
      redirect_to root_url, alert: "User registration is disabled."
    end
  end

  def create
    if @user
      redirect_to root_url
    else
      redirect_to root_url, alert: "User registration is disabled."
      # @user = User.new(user_params)
      # if @user.save
      #  sign_in @user
      #  redirect_to @user, success: 'welcome'
      # else
      #  render 'new'
      # end
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      sign_in @user
      redirect_to @user, success: 'Profile updated'
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url, success: 'User destroyed'
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
