class CommitsController < ApplicationController
  def index
    @commits = Commit.all(current_user)
    render json: @commits
  end
end
