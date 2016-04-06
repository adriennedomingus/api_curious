class Organization < OpenStruct

  def self.service(current_user)
    GithubService.new(current_user)
  end

  def self.all(current_user)
    all_orgs = []
    orgs_hash = service(current_user).organizations
    orgs_hash.each do |org_hash|
      all_orgs << self.new(org_hash)
    end
    all_orgs
  end
end
