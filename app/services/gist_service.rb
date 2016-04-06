class GistService
  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
    @_connection = Faraday.new("https://api.github.com")
    connection.headers['Authorization'] = "token #{current_user.token}"
    connection.headers['Content-Type'] = "application/json"
  end

  def all_gists
    get("/users/#{current_user.nickname}/gists")
  end

  def gist(id)
    get("/gists/#{id}")
  end

  def create(hash)
    hash = hash.to_json
    connection.post("/gists", hash)
  end

  def destroy_gist(the_gist)
    connection.delete("/gists/#{the_gist.id}")
  end

  private

    def connection
      @_connection
    end

    def get(path)
      JSON.parse(connection.get(path).body)
    end
end
