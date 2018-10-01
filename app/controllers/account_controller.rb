class AccountController < ApplicationController
  before_action :require_login


  def index
    @user = User.find(params[:user_id])
  end

  def security
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.js
    end
  end

  def update_password
    @user = User.find(params[:user_id])
    if @user.authenticated?(params[:user][:old_password])
      if @user.update_password(params[:user][:new_password], params[:user][:confirm_password])
        flash[:success] = "Password Updated!"
        redirect_back(fallback_location: root_path)
      else
        flash[:danger] = "Password does not match"
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:danger] = "Please key in your current password"
      redirect_back(fallback_location: root_path)
    end
  end
end
