require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :rack_test, using: :chrome, screen_size: [1400, 1400]
end
