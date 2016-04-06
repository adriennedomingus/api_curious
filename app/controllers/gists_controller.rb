class GistsController < ApplicationController
  def index
    if current_user
      @gistservice = GistService.new(current_user)
    end
  end

  def show
    @gist = Gist.find(current_user, params[:id])
    @name = @gist["files"].keys.first
  end

  def create
    Gist.create_struct(current_user, params)
    redirect_to user_gists_path(current_user)
  end

  def destroy
    the_gist = Gist.find(current_user, params[:id])
    the_gist.delete(current_user)
    redirect_to user_gists_path(current_user)
  end
end
