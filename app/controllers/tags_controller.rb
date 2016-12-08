class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @products = @tag.products
    @tags = Tag.all
    @user = current_user
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      flash[:notice] = "Tag Updated"
      redirect_to tag_path(@tag)
    else
      flash.now[:alert] = "Tag NOT updated, please try again."
      render :edit
    end
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
  def tag_params
    params.require(:tag).permit(:name)
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end
end
