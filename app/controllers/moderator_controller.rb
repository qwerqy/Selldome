class ModeratorController < ApplicationController
  before_action :require_login
  skip_before_action :verify_authenticity_token, :only => [:verify]

  def index
    if current_user.moderator? || current_user.superadmin?
      @listing = Listing.order(:name).page params[:page]
      respond_to do |format|
        format.html
        format.js
      end
    else
      flash[:danger] = "You have no access!"
      redirect_to root_path
    end
  end

  def unverified_listings
    if current_user.moderator? || current_user.superadmin?
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
        format.js { render 'moderator/unverified_listings'}
      end
    else
      flash[:danger] = "You have no access!"
      redirect_to root_path
    end
  end

  def verified_listings
    if current_user.moderator? || current_user.superadmin?
      @listing = Listing.order(:name).page params[:page]
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = "You have no access!"
      redirect_to root_path
    end
  end

  def all_listings
    if current_user.moderator? || current_user.superadmin?
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = "You have no access!"
      redirect_to root_path
    end
  end

  def view_listing
    if current_user.moderator? || current_user.superadmin?
      @listing = Listing.find(params[:id])
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = "You have no access!"
      redirect_to root_path
    end
  end

  def edit_listing
    if current_user.moderator? || current_user.superadmin?
      @listing = Listing.find(params[:id])
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = "You have no access!"
      redirect_to root_path
    end
  end

  def destroy_listing
    if current_user.moderator? || current_user.superadmin?
      @listing = Listing.find(params[:id])
      @listing.destroy
      redirect_to root_path
    else
      flash[:danger] = "You have no access!"
      redirect_to root_path
    end
  end

  def search
    if current_user.moderator? || current_user.superadmin?
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = "You have no access!"
      redirect_to root_path
    end
  end
end
