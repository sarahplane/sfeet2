class Api::V1::ProductsController < Api::V1::BaseController
  def index
    products = Product.all
    render json: products, status: 200
  end

  def show
    product = Product.find(params[:id])
    render json: product, status: 200
  end
end
