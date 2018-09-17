class ModeratorController < ApplicationController
  before_action :require_login
  skip_before_action :verify_authenticity_token, :only => [:verify]

  def index
    if current_user.moderator? || current_user.superadmin?
      @listing = Listing.order(:name).page params[:page]
      render template: 'moderator/index'
      respond_to do |format|
        format.html
        format.js
      end
    else
      flash[:danger] = "You have no access!"
      redirect_to root_path
    end
  end

  def pending_verification
    if current_user.moderator? || current_user.superadmin?
      @listing = Listing.order(:name).page params[:page]
      render template: 'shared/pending-verification'
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = "You have no access!"
      redirect_to root_path
    end
  end

  def verify
    if current_user.moderator? || current_user.superadmin?
      @listing = Listing.find(params[:id])
      @listing.update(verified: params[:verified])
      respond_to do |format|
        format.js { render 'shared/pending-verification'}
      end
    else
      flash[:danger] = "You have no access!"
      redirect_to root_path
    end
  end

  def verified_listings
    if current_user.moderator? || current_user.superadmin?
      @listing = Listing.order(:name).page params[:page]
      render template: 'shared/verified-listings'
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = "You have no access!"
      redirect_to root_path
    end
  end
end
