class Repository < OpenStruct

  def self.service(current_user)
    GithubService.new(current_user)
  end

  def self.all(current_user)
    all_repos = []
    repos_hash = service(current_user).repos
    repos_hash.each do |repo_hash|
      all_repos << self.new(repo_hash)
    end
    all_repos
  end
end
