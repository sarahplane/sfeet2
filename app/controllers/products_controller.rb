class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @products = Product.all
    @tags = Tag.all
  end

  def show
    @tags = Tag.all
  end

  def new
    @product = Product.new
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
    params.require(:product).permit(:name, :price, :tag_list)
  end

  def set_product
    @product = Product.find(params[:id])
  end

end
