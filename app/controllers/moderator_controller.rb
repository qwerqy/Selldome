class ModeratorController < ApplicationController
  before_action :require_login
  def index
    if current_user.moderator? || current_user.superadmin?
      @listing = Listing.order(:name).page params[:page]
      render template: 'moderator/index'
      respond_to do |format|
        format.html
        format.js
      end
    else
      redirect_to root_path
    end
  end

  def pending_verification
    @listing = Listing.order(:name).page params[:page]
    render template: 'shared/pending-verification'
  end

  def verify
    @listing = Listing.find(params[:id])

    @listing.update(verified: params[:verified])
  end

  def verified_listings
    @listing = Listing.order(:name).page params[:page]
    render template: 'shared/verified-listings'
  end
end
