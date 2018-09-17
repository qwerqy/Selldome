class SuperadminController < ApplicationController
  before_action :require_login
  def index
    if current_user.superadmin?
      render template: 'superadmin/index'
    else
      redirect_to root_path
    end
  end

  def all_users
    render template: 'shared/view-users'
  end
end
