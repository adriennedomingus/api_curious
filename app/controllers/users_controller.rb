class UsersController < ApplicationController
  def show
    if current_user
      @service = GithubService.new(current_user)
    end
  end
end
