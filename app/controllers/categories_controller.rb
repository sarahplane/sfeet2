class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:show]
  before_action :admin_function, only: [:index, :new, :create, :edit, :update, :destroy]

  def index
    @categories = Category.all
    @category = Category.new
  end

  def show
    @products = @category.products.includes(:reviews)
    @categories = Category.all.includes(:reviews)
    @tags = Tag.all
    @user = current_user
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category successfully added."
      redirect_to categories_path
    else
     flash[:alert] = "Category NOT added, please try again."
     redirect_to categories_path
    end
  end

  def edit
    respond_to do |format|
      format.html { head :bad_request}
      format.js
    end
  end


  def update
    if @category.update(category_params)
      respond_to do |format|
        format.html { head :bad_request}
        format.js
      end
    else
      Rails.logger.info 'failed to update'
    end
  end


  def destroy
    @category.destroy
    respond_to do |format|
      format.html
      format.js
    end
  end

private
  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def admin_function
    if current_user.admin?
      @user = current_user
    else
      flash[:alert] = "Sorry You are not authorized to access this page."
      redirect_to root_path
    end
  end

end
