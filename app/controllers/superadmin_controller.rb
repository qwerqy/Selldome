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
        render template: 'superadmin/delete-user'
        respond_to do |format|
          format.js
        end
      else
        flash[:danger] = "You have no access!"
        redirect_to root_path
      end
    end

    def destroy
      if current_user.superadmin?
        @user = User.find(params[:id])
        @user.destroy
        @user.listings.destroy_all
      else
        flash[:danger] = "You have no access!"
        redirect_to root_path
      end
    end
end
