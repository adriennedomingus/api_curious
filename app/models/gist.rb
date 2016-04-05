class Gist < OpenStruct

  def self.find(current_user, id)
    gs = GistService.new(current_user)
    gist = gs.gist(id)
  end
end
