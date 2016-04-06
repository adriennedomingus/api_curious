describe Commit do
  context ".all" do
    it "returns a collection of commits" do
      VCR.use_cassette "commit.all" do
        current_user = User.create(provider: 'github', uid: '1', name: "Adrienne", token: ENV['USER_TOKEN'], nickname: 'adriennedomingus')
        commits = Commit.all(current_user)
        commit = commits.first
        expect(commits.count).to eq(11)
        expect(commit.class).to eq(Commit)
        expect(commit.repo).to eq("adriennedomingus/api_curious")
      end
    end
  end

  context ".all_following" do
    it "returns a collection of commits" do
      VCR.use_cassette "commit.all_following" do
        current_user = User.create(provider: 'github', uid: '1', name: "Adrienne", token: ENV['USER_TOKEN'], nickname: 'adriennedomingus')
        commits = Commit.all_following(current_user)
        commit = commits.first
        expect(commits.count).to eq(32)
        expect(commit.class).to eq(Commit)
        expect(commit.repo).to eq("adamhundley/exercism")
      end
    end
  end
end
