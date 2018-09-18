class SuperadminController < ApplicationController
  before_action :require_login
    def index
      if current_user.superadmin?
        render template: 'superadmin/index'
      else
        flash[:danger] = "You have no access!"
        redirect_to root_path
      end
    end

    def all_users
      if current_user.superadmin?
        render template: 'superadmin/view-users'
        respond_to do |format|
          format.js
        end
      else
        flash[:danger] = "You have no access!"
        redirect_to root_path
      end
    end

    def update_users
      if current_user.superadmin?
        render template: 'superadmin/update-users'
        respond_to do |format|
          format.js
        end
      else
        flash[:danger] = "You have no access!"
        redirect_to root_path
      end
    end

    def delete_user
      if current_user.superadmin?
        @user = User.find(params[:id])

        render template: 'superadmin/delete-user'

        respond_to do |format|
          format.js # => delete_user.js.erb
        end

      else
        flash[:danger] = "You have no access!"
        redirect_to root_path
      end
    end

    def destroy_user
      if current_user.superadmin?
        @user = User.find(params[:id])
        @user.destroy
        redirect_to admin_panel_path
      else
        flash[:danger] = "You have no access!"
        redirect_to admin_panel_path
      end
    end

    def update_user
      @user = User.find(params[:id])
      render template: 'superadmin/edit-user'
      respond_to do |format|
        format.js
      end
    end

    def confirm_update
      if current_user.superadmin?
        @user = User.find(params[:id])
        @user.update_attributes(user_params)
        if @user.save
          flash[:warning] = "User has been edited"
          redirect_to admin_panel_path
        end
      else
        flash[:danger] = "You have no access!"
        redirect_to admin_panel_path
      end
    end

private

  def user_params
    params.require(:user)
        .permit(
          :first_name,
          :last_name,
          :country,
          :gender,
          :birthday,
          :email,
          :phone
        )
  end
end
