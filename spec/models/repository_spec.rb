require 'rails_helper'

describe Repository do
  context ".all" do
    it "returns a collection of legislators" do
      VCR.use_cassette "repository.all" do
        current_user = User.create(provider: 'github', uid: '1', name: "Adrienne", token: ENV['USER_TOKEN'], nickname: 'adriennedomingus')
        repositories = Repository.all(current_user)
        repository = repositories.first
        expect(repositories.count).to eq(25)
        expect(repository.class).to eq(Repository)
        expect(repository.name).to eq("adriennedomingus.github.io")
      end
    end
  end
end
