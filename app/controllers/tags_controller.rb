class TagsController < ApplicationController

  def index
    @tags = Tag.all
  end

  def create
    Tag.create(tags_params)
  end

  private
  def tags_params
    params.require(:tag).permit(:name)
  end

end
