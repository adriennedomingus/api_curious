require 'open-uri'

class GithubService
  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
    @_connection = Faraday.new("https://api.github.com")
    connection.headers['Authorization'] = "token #{current_user.token}"
  end

  def followers
    get("/users/#{current_user.nickname}/followers")
  end

  def following
    get("/users/#{current_user.nickname}/following")
  end

  def organizations
    get("/users/#{current_user.nickname}/orgs")
  end

  def repos
    get("/users/#{current_user.nickname}/repos")
  end

  def starred
    get("/users/#{current_user.nickname}/starred")
  end

  def current_streak
    main_page.css('#contributions-calendar .contrib-column:nth-of-type(3) .contrib-number').text
  end

  def longest_streak
    main_page.css('#contributions-calendar .contrib-column:nth-of-type(2) .contrib-number').text
  end

  def contributions_year
    main_page.css('#contributions-calendar .contrib-column-first').text.split("\n")[2].strip
  end

  def recent_commits
    all_events = get("users/#{current_user.nickname}/events")
    commits = push_events(all_events)
    limited = commits.map do |commit|
      scope_commits(commit)
    end
    limited
  end

  def following_feed
    feed = []
    following = get("/users/#{current_user.nickname}/following")
    following.each do |followed|
      all_events = get("users/#{followed["login"]}/events")
      commits = push_events(all_events)
      commits.map do |commit|
        feed << scope_commits(commit)
      end
    end
    feed
  end

  private

    def connection
      @_connection
    end

    def push_events(all_events)
      all_events.select { |event| event["type"] == "PushEvent"}
    end

    def scope_commits(commit)
      {repo: commit["repo"]["name"], message: commit["payload"]["commits"].first["message"]}
    end

    def get(path)
      JSON.parse(connection.get(path).body)
    end

    def main_page
      Nokogiri::HTML(open("https://github.com/#{current_user.nickname}"))
    end
end
