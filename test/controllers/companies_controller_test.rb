require 'test_helper'

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  test "should get ParameterSanitizer" do
    get companies_ParameterSanitizer_url
    assert_response :success
  end

end
