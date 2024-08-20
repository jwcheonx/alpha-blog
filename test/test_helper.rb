ENV['RAILS_ENV'] ||= 'test'

require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    parallelize

    fixtures :all

    def log_in_as(user)
      post login_path, params: { credentials: { email: user.email, password: 'password' } }
    end
  end
end
