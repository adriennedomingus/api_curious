class GistsController < ApplicationController
  def index
    @gists = Gist.all(current_user)
  end

  def show
    @gist = Gist.find(current_user, params[:id])
  end

  def create
    Gist.create_struct(current_user, params)
    redirect_to user_gists_path(current_user)
  end

  def destroy
    Gist.find(current_user, params[:id]).delete(current_user)
    redirect_to user_gists_path(current_user)
  end
end
