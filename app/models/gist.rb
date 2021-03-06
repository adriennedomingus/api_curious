class Gist < OpenStruct

  def self.all(current_user)
    gs = GistService.new(current_user)
    all = gs.all_gists
    gist_structs = []
    all.each do |the_gist|
      gist_structs << new(the_gist)
    end
    gist_structs
  end

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

  def name
    self.files.keys.first
  end

  def contents
    self.files[name]["content"]
  end

  def delete(current_user)
    gs = GistService.new(current_user)
    gs.destroy_gist(self)
  end

  def created_date
    Date.parse(self.created_at).strftime("%B %d, %Y")
  end
end
