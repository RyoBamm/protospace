class CommentsController < ApplicationController
  def create
    @comment = Comment.includes(:user).new(content: comment_params[:content], prototype_id: comment_params[:prototype_id], user_id: current_user.id)
    if user_signed_in?
      if @comment.save
        respond_to do |format|
          format.html { prototype_path(@comment.prototype) }
          format.json
        end
      end
    else
      redirect_to new_user_session_path
    end
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
