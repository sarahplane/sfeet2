class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :destroy]
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @tags_sorted = Tag.order("tags.name asc")
    @products = Product.all
  end

  def destroy
    if @tag.destroy
      flash[:notice] = "Tag Deleted"
    else
      flash[:alert] = "Tag NOT deleted, please try again."
    end
    redirect_to products_path
  end

private
  def set_tag
    @tag = Tag.find(params[:id])
  end
end
