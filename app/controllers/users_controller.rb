class UsersController < ApplicationController
  def show
    if current_user
      @service = Github.new(current_user)
    end
  end
end
