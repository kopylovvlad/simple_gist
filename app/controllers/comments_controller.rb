class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_gist

  def create
    @comment.gist_id = @gist.id
    if @comment.save
      flash[:success] = I18n.t('comment_success_create')
    else
      flash[:error] = I18n.t('comment_error_create')
    end
    redirect_to gist_path(@gist)
  end

  def destroy
    @comment.destroy
    flash[:success] = I18n.t('comment_success_destroy')
    redirect_to gist_path(@gist)
  end

  private

  def set_gist
    @gist = Gist.find(params[:gist_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end
end
