class HomeController < ApplicationController # :nodoc:
  def main
    @gists = Gist.preload(:user).limit(10)
  end
end
