class CommitsController < ApplicationController
  def index
    @commits = Commit.all(current_user)
    render json: @commits
  end

  def following
    @following_commits = Commit.all_following(current_user)
    render json: @following_commits
  end
end
