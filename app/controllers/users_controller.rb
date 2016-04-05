class UsersController < ApplicationController
  def show
    if current_user
      @repos = Github.new(current_user).repos
    end
  end
end
