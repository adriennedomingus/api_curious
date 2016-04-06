class Gist < OpenStruct

  def self.find(current_user, id)
    gs = GistService.new(current_user)
    gist = gs.gist(id)
    new(gist)
  end

  def self.create_struct(current_user, params)
    hash = { description: params[:description],
             public: true,
             files: {
               params[:title] => {
                 content: params[:contents]
               }
             }}
    GistService.new(current_user).create(hash)
  end

  def delete(current_user)
    gs = GistService.new(current_user)
    gs.destroy_gist(self)
  end
end
