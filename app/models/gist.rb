class Gist < OpenStruct

  def self.find(current_user, id)
    gs = GistService.new(current_user)
    gist = gs.gist(id)
  end

  def self.create_struct(current_user, params)
    hash = { description: params[:description],
             public: true,
             files: {
               params[:file] => {
                 content: File.read("./app/#{params[:file]}")
               }
             }}
    GistService.new(current_user).create(hash)
  end
end
