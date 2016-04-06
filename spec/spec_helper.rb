module SpecHelpers
  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github',
      uid: "12345",
      info: {
        name: "Adrienne",
        nickname: "adriennedomingus"
            },
      credentials: {
        token: "69d5253340d4f835a09ce8b3b3abffc799af961b"
                    },
      extra: {
        raw_info: {
          avatar_url: "https://avatars.githubusercontent.com/u/10178677?v=3"
        }
              }
      })
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.include SpecHelpers
end
