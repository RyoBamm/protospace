class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      redirect_to ({ action: new }), alert: 'YNew prototype was unsuccessfully created'
    end
  end

  def show
    @comments = @prototype.comments.order('created_at DESC').includes(:user)
  end

  def edit
  end

  def update
    # binding.pry
    if @prototype[:user_id] == current_user.id
      if @prototype.update(prototype_params)
        flash.now[:flash] = "編集しました"
        render :index
      else
        render :edit, alert: 'prototype was unsuccessfully updated'
      end
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    if prototype.user_id == current_user.id
      prototype.destroy
    end
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:id, :content, :status]
    )
  end
end
