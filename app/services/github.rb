class Github
  attr_reader :connection, :current_user

  def initialize(current_user)
    @current_user = current_user
    @connection = Faraday.new("https://api.github.com")
  end

  def followers
    JSON.parse(connection.get("/users/#{current_user.nickname}/followers").body)
  end

  def following
    JSON.parse(connection.get("/users/#{current_user.nickname}/following").body)
  end
end
