class ReviewController < ApplicationController
  def new
<<<<<<< HEAD
    @listing = Listing.find(params[:listing_id])
    @review = Review.new
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.listing_id = @listing.id
    byebug
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
=======
  end

  def create
  end


>>>>>>> 517ca7c4cc17b57676ff43b7b773860a32330bce
end
