class GistService
  attr_reader :connection, :current_user

  def initialize(current_user)
    @current_user = current_user
    @connection = Faraday.new("https://api.github.com")
    @connection.headers['Authorization'] = "token #{current_user.token}"
    @connection.headers['Content-Type'] = "application/json"
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

  private

    def get(path)
      JSON.parse(connection.get(path).body)
    end
end
