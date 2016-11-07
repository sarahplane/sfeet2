class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]
  #need to add before action for administrator for destroy, update, edit, create
  helper ProductsHelper

  def index
    @tags = Tag.all
    @reviews = Review.all
    @user = current_user
    @products = Product.search(params[:search])
    render :template => "products/search", :locals => {:products => @products}
  end

  def show
    @tags = Tag.all
    @review = Review.new
    @user = current_user
  end

  def new
    @product = Product.new
    @review = Review.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:notice] = "Product successfully added."
      redirect_to products_path
    else
      flash.now[:alert] = "Product NOT added, please try again."
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      flash[:notice] = "Product Updated"
      redirect_to product_path(@product)
    else
      flash.now[:alert] = "Product NOT updated, please try again."
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:notice] = "Product Deleted"
    else
      flash[:alert] = "Product NOT deleted, please try again."
    end
    redirect_to products_path
  end


private
  def product_params
    params.require(:product).permit(:name, :price, :tag_list, :category_id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

end
