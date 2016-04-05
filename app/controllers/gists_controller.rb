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
end
