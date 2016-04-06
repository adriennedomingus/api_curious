class RepositoriesController < ApplicationController
  def index
    @repositories = Repository.all(current_user)
    render json: @repositories
  end
end
