class ReviewController < ApplicationController
  def new
    @listing = Listing.find(params[:listing_id])
    @review = Review.new
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.listing_id = @listing.id
    if @review.save
      flash[:success] = "Thank you for the review!"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Uh Oh! Something's wrong!"
      redirect_back(fallback_location: root_path)
    end

  end

private

  def review_params
    params.require(:review).permit(
      :rating,
      :comment,
      :listing_id,
      :user_id
    )
  end
end
