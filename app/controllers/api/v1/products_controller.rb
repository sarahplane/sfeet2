class Api::V1::ProductsController < Api::V1::BaseController
  
  def index
    products = Product.all
    render json: products, status: 200
  end

  def show
    product = Product.find(params[:id])
    render json: product, status: 200
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      render json: { status: 201, message: "Product successfully added."}.to_json
    else
      render json: { status: 400, message: "Product NOT added, please try again."}.to_json
    end
  end

private
  def product_params
    params.require(:product).permit(:name, :price, :tag_list, :category_id)
  end

end
