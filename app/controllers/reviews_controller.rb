class ReviewsController < ApplicationController

  def create
    @product = Product.find(params[:product_id])
    @review = Review.new(review_params)
    @review.product = @product
    @review.user_id = current_user.id if current_user

    if @review.save
      flash[:notice] = "Review Submitted"
    else
       flash[:alert] = "Review Not Submitted"
    end
    redirect_to @product
  end

private
  def review_params
    params.require(:review).permit(:rating, :comment, :product_id, :user_id)
  end
end
