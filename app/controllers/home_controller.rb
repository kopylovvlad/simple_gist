class HomeController < ApplicationController # :nodoc:
  def main
    @gists = Gist.preload(:user).limit(10).map(&:load_comments_count)
  end
end
