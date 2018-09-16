class ModeratorController < ApplicationController
  def index
    render template: 'moderator/index'
  end
end
