class CommentsController < ApplicationController
  def create
    if user_signed_in?
      @comment = Comment.includes(:user).new(content: comment_params[:content], prototype_id: comment_params[:prototype_id], user_id: current_user.id)
      if @comment.save
        respond_to do |format|
          format.html { prototype_comments_path(@comment) }
          format.json
        end
      end
    else
      redirect_to new_user_session_path
    end
  end

  def edit
    @comment = Comment.includes(:user).find(comment_params[:id])
  end

  def show
    @comment = Comment.includes(:user).find(comment_params[:id])
  end

  def destroy
    deletingComment = Comment.find(comment_params[:id])
    @comment = deletingComment
    if @comment.user_id == current_user.id
      deletingComment.destroy
    end
  end

  def update
    @comment = Comment.find(comment_params[:id])
    if @comment.user_id == current_user.id
      @comment.update( content: comment_params[:content] )
    end
  end

  private
  def comment_params
    params.permit(:id, :content, :prototype_id)
  end
end
