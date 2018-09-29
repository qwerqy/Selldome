class ReviewController < ApplicationController
  def new
    @listing = Listing.find(params[:listing_id])
    @review = Review.new
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @review = @listing.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      flash[:success] = "Thank you for the review!"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = @review.errors.full_messages.to_sentence
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
