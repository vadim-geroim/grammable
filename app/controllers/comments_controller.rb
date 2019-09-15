class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @gram = Gram.find_by_id(params[:gram_id])
    return render_not_found if @gram.blank?
    @comment = @gram.comments.create(comment_params.merge(user: current_user))
    return redirect_to root_path if @comment.valid?
  end

  private

  def comment_params
    params.require(:comment).permit(:message)
  end
end
