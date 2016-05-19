class UsersController < ApplicationController
  before_filter :set_user, only: [:show, :edit, :update]
  before_filter :validate_authorization_for_user, only: [:edit, :update]


  # GET /users/1
  def show
  end

  # GET /users/1/edit
  def edit
  end

  def index
    @users = User.all
  end

  # PATCH/PUT /users/1
  def update
    if @user.update_attributes(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def update_login_password
    @user = User.find(current_user.id)
    if @user.update(user_login_params)
      # Sign in the user by passing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      render "users/update_login"
    end
  end

  def update_login
    @user = User.find(current_user.id)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def validate_authorization_for_user
       redirect_to root_path unless @user == current_user
    end

    def user_params
      params.require(:user).permit(:name, :user, :about)
    end

    def user_login_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end
