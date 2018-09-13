class CommentsController < ApplicationController
  def create
    @comment = Comment.create(content: comment_params[:content], prototype_id: comment_params[:prototype_id], user_id: current_user.id)
      redirect_to "/prototypes/#{@comment.prototype.id}"
  end

  def delete
  end

  def update
  end

  private
  def comment_params
    params.permit(:content, :prototype_id)
  end
end
