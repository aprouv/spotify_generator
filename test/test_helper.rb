ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def spotify_mock
    OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new({
      :provider => 'spotify',
      :uid => 'dfghyjuikoiuzjkodeuhfjeios',
      :credentials => {
        :refresh_token => 'oiuhijzkpdkojhu7765678',
        :token => 'JHGUI9876TYFV67Uj'
        },
      :info => {
        :email => 'test70@test.com',
      }
    })
  end

end
