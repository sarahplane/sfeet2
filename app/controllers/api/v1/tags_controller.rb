class Api::V1::TagsController < Api::V1::BaseController
  def index
    tags = Tag.all
    render json: tags, status: 200
  end

  def show
    tag = Tag.find(params[:id])
    render json: tag, status: 200
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      render json: { status: 201, message: "Tag successfully added."}.to_json
    else
      render json: { status: 400, message: "Tag NOT added, please try again."}.to_json
    end
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      render json: { status: 201, message: "Tag successfully updated."}.to_json
    else
      render json: { status: 400, message: "Tag NOT updated, please try again."}.to_json
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    if @tag.destroy
      render json: { status: 201, message: "Tag successfully deleted."}.to_json
    else
      render json: { status: 400, message: "Tag NOT deleted, please try again."}.to_json
    end
  end

private
  def tag_params
    params.require(:tag).permit(:name)
  end
end
