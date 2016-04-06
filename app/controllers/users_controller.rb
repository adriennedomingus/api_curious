class UsersController < ApplicationController
  def show
    if current_user
      @service = GithubService.new(current_user)
      @repos = Repository.all(current_user)
      @orgs = Organization.all(current_user)
      @commits = Commit.all(current_user)
      @following_commits = Commit.all_following(current_user)
    end
  end
end
