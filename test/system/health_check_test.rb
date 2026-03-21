require "application_system_test_case"

class HealthCheckTest < ApplicationSystemTestCase
  test "health check returns ok" do
    visit rails_health_check_path

    assert_equal 200, page.status_code
  end
end
