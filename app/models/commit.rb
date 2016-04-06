class Commit < OpenStruct

  def self.service(current_user)
    GithubService.new(current_user)
  end

  def self.all(current_user)
    commits_hash = service(current_user).recent_commits
    create_commits(commits_hash)
  end

  def self.all_following(current_user)
    commits_hash = service(current_user).following_feed
    create_commits(commits_hash)
  end

  private

  def self.create_commits(commits_hash)
    all_commits = []
    commits_hash.each do |commit_hash|
      all_commits << self.new(commit_hash)
    end
    all_commits
  end
end
