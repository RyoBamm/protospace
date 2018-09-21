class LikesController < ApplicationController
  before_action :set_post

  def create
    @like = Like.create(user_id: current_user.id, prototype_id: params[:prototype_id])
    @likes = Like.where(prototype_id: params[:prototype_id])
    @prototype.reload
  
    # render "show"
    # redirect_to :root, notice: 'like was successfully created'
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, prototype_id: params[:prototype_id])
    like.destroy
    @likes = Like.where(prototype_id: params[:prototype_id])
    @prototype.reload
    # render "show"
    # redirect_to :root, notice: 'like was successfully deleted'
  end

  private

  def set_post
    @prototype = Prototype.find(params[:prototype_id])
  end

end
