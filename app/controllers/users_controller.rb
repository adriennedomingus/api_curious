class UsersController < ApplicationController
  def show
    if current_user
      @repos = Github.new(current_user).repos
      @orgs = Github.new(current_user).organizations
    end
  end
end
