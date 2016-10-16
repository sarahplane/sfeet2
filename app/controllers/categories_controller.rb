class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @categories = Category.all
  end

  def show
    @categories = Category.all
    @tags = Tag.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category successfully added."
      redirect_to categories_path
    else
      flash.now[:alert] = "Category NOT added, please try again."
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category Updated"
      redirect_to category_path(@category)
    else
      flash.now[:alert] = "Category NOT updated, please try again."
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = "Category Deleted"
    else
      flash[:alert] = "Category NOT deleted, please try again."
    end
    redirect_to categories_path
  end

private
  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

 end
