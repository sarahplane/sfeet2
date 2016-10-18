class ReviewsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @reviews = Review.all
  end

  def create
    @product = Product.find(params[:product_id])
    @user = User.find(params[:user_id])
    @review = Review.new(review_params)
    @review.product = @product

    if @review.save
      flash[:notice] = "Review Submitted"
    else
       flash[:alert] = "Review Not Submitted"
    end
    redirect_to @product
  end


  def update
    if @review.update(review_params)
      flash[:notice] = "Review Updated"
#      redirect_to reviews_path
# I want this to be on the same page as Index and only done through Ajax & JS.
    else
      flash.now[:alert] = "Review NOT updated, please try again."
      render :edit
    end
  end

  def destroy
    if @review.destroy
      flash[:notice] = "Review Deleted"
    else
      flash[:alert] = "Review NOT deleted, please try again."
    end
#    redirect_to reviews_path
# I want this to be on the same page as Index and only done through Ajax & JS.
  end


private
  def review_params
    params.require(:review).permit(:rating, :comment, :product_id, :user_id)
  end
end
