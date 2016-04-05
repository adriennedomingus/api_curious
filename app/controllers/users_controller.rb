class UsersController < ApplicationController
  def show
    if current_user
      @service = GithubService.new(current_user)
      @repos = Repository.all(current_user)
    end
  end
end
