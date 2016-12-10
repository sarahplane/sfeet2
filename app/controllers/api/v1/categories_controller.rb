class Api::V1::CategoriesController < Api::V1::BaseController
  def index
    categories = Category.all
    render json: categories, status: 200
  end

  def show
    category = Category.find(params[:id])
    render json: category, status: 200
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      render json: { status: 201, message: "Category successfully added."}.to_json
    else
      render json: { status: 400, message: "Category NOT added, please try again."}.to_json
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      render json: { status: 201, message: "Category successfully updated."}.to_json
    else
      render json: { status: 400, message: "Category NOT updated, please try again."}.to_json
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      render json: { status: 201, message: "Category successfully deleted."}.to_json
    else
      render json: { status: 400, message: "Category NOT deleted, please try again."}.to_json
    end
  end

private
  def category_params
    params.require(:category).permit(:name)
  end
end
