require 'rails_helper'

describe Gist do
  context ".all" do
    it "returns a collection of gists" do
      VCR.use_cassette "gist.all" do
        current_user = User.create(provider: 'github', uid: '1', name: "Adrienne", token: ENV['USER_TOKEN'], nickname: 'adriennedomingus')
        gists = Gist.all(current_user)
        the_gist = gists.first
        expect(gists.count).to eq(30)
        expect(the_gist.class).to eq(Gist)
        expect(the_gist.files.keys.first).to eq("test_gist_from_api.md")
      end
    end
  end

  context ".find" do
    it "returns a collection of gists" do
      VCR.use_cassette "gist.find" do
        current_user = User.create(provider: 'github', uid: '1', name: "Adrienne", token: ENV['USER_TOKEN'], nickname: 'adriennedomingus')
        the_gist = Gist.find(current_user, "a9dced3bd23129bedb361754caed4e65")
        expect(the_gist.class).to eq(Gist)
        expect(the_gist.files.keys.first).to eq("Workflow.md")
      end
    end
  end

  context ".create_struct" do
    it "returns a collection of gists" do
      VCR.use_cassette "gist.create_struct" do
        current_user = User.create(provider: 'github', uid: '1', name: "Adrienne", token: ENV['USER_TOKEN'], nickname: 'adriennedomingus')
        params = { :description => "Testing creating gists from API",
                   :title => "test_gist_from_api.md",
                   :contents => "I'm creating a gist from my app using the github api",
                 }
        the_gist = Gist.create_struct(current_user, params)
        response = JSON.parse(the_gist.body)
        expect(response["created_at"]).to eq("2016-04-06T20:49:48Z")
      end
    end
  end

  context "delete" do
    it "returns a collection of gists" do
      VCR.use_cassette "gist#delete" do
        current_user = User.create(provider: 'github', uid: '1', name: "Adrienne", token: ENV['USER_TOKEN'], nickname: 'adriennedomingus')
        the_gist = Gist.find(current_user, "a84f459241fc4213edaf26368eab97e7")
        response = the_gist.delete(current_user)
        expect(response.env["method"]).to eq(:delete)
        expect(response.env["url"].path).to eq("/gists/a84f459241fc4213edaf26368eab97e7")
      end
    end
  end
end
