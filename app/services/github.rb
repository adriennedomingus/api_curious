require 'open-uri'

class Github
  attr_reader :connection, :current_user

  def initialize(current_user)
    @current_user = current_user
    @connection = Faraday.new("https://api.github.com")
    @connection.headers['Authorization'] = "token #{current_user.token}"
  end

  def followers
    JSON.parse(connection.get("/users/#{current_user.nickname}/followers").body)
  end

  def following
    JSON.parse(connection.get("/users/#{current_user.nickname}/following").body)
  end

  def organizations
    JSON.parse(connection.get("/users/#{current_user.nickname}/orgs").body)
  end

  def repos
    JSON.parse(connection.get("/users/#{current_user.nickname}/repos").body)
  end

  def starred
    JSON.parse(connection.get("/users/#{current_user.nickname}/starred").body)
  end

  def current_streak
    data = Nokogiri::HTML(open("https://github.com/#{current_user.nickname}"))
    data.css('#contributions-calendar .contrib-column:nth-of-type(2) .contrib-number').text
  end
end
