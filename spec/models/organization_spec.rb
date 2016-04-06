describe Organization do
  context ".all" do
    it "returns a collection of legislators" do
      VCR.use_cassette "organization.all" do
        current_user = User.create(provider: 'github', uid: '1', name: "Adrienne", token: ENV['USER_TOKEN'], nickname: 'adriennedomingus')
        organizations = Organization.all(current_user)
        organization = organizations.first
        expect(organizations.count).to eq(0)
      end
    end
  end
end
