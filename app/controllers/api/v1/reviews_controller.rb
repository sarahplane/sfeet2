class Api::V1::ReviewsController < Api::V1::BaseController

  def create
    @product = Product.find(params[:product_id])
    @review = Review.new(review_params)
    @review.product = @product
    @review.user_id = current_user.id if current_user

    if @review.save
      render json: { status: 201, message: "Review successfully added." }.to_json
    else
      render json: { status: 400, message: "Review NOT added, please try again." }.to_json
    end
  end

private
  def review_params
    params.require(:review).permit(:rating, :comment, :product_id, :user_id)
  end
end
