class GistsController < ApplicationController
  load_and_authorize_resource

  def index
    page = params[:page] || 1
    @gists = Gist.preload(:user).all
    if params[:query].present?
      @gists = @gists.search(params[:query])
    end
    @gists = @gists.paginate(page: page)
  end

  def new; end

  def show
    @comments = @gist.comments.preload(:user, :gist)
  end

  def edit; end

  def create
    @gist.user_id = current_user.id
    if @gist.save
      redirect_to gist_path(@gist)
    else
      render :new
    end
  end

  def update
    if @gist.update_attributes(gist_params)
      redirect_to gist_path(@gist)
    else
      render :edit
    end
  end

  def destroy
    @gist.destroy
    flash[:success] = I18n.t('gist_success_destroy')
    redirect_to user_path(user_login: current_user.login)
  end

  private

  def gist_params
    params.require(:gist).permit(:title, :body, :lang_mode, :user_id)
  end
end
