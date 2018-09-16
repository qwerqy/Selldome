class ModeratorController < ApplicationController
  before_action :require_login
  def index
    if current_user.moderator? || current_user.superadmin?
    render template: 'moderator/index'
    else
    redirect_to root_path
    end
  end
end
