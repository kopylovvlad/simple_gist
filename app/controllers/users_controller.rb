class UsersController < ApplicationController # :nodoc:
  def show
    @user = User.find_by(login: params[:user_login])
    page = params[:page] || 1
    @gists = @user.gists.preload(:user).paginate(page: page)
  end
end
