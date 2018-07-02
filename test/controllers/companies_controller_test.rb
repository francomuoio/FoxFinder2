require 'test_helper'

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company = companies(:one)
  end

  test "should get index" do
    get companies_index_url
    assert_response :success
  end

  test "should get new" do
    get new_company_url
    assert_response :success
  end

  test "should create company" do
    assert_difference('Companies.count') do
      post companies_index_url, params: { company: {  } }
    end

    assert_redirected_to company_url(Companies.last)
  end

  test "should show company" do
    get company_url(@company)
    assert_response :success
  end

  test "should get edit" do
    get edit_company_url(@company)
    assert_response :success
  end

  test "should update company" do
    patch company_url(@company), params: { company: {  } }
    assert_redirected_to company_url(@company)
  end

  test "should destroy company" do
    assert_difference('Companies.count', -1) do
      delete company_url(@company)
    end

    assert_redirected_to companies_index_url
  end
end
