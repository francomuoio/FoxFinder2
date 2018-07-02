require 'test_helper'

class NegociatorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @negociator = negociators(:one)
  end

  test "should get index" do
    get negociators_url
    assert_response :success
  end

  test "should get new" do
    get new_negociator_url
    assert_response :success
  end

  test "should create negociator" do
    assert_difference('Negociator.count') do
      post negociators_url, params: { negociator: {  } }
    end

    assert_redirected_to negociator_url(Negociator.last)
  end

  test "should show negociator" do
    get negociator_url(@negociator)
    assert_response :success
  end

  test "should get edit" do
    get edit_negociator_url(@negociator)
    assert_response :success
  end

  test "should update negociator" do
    patch negociator_url(@negociator), params: { negociator: {  } }
    assert_redirected_to negociator_url(@negociator)
  end

  test "should destroy negociator" do
    assert_difference('Negociator.count', -1) do
      delete negociator_url(@negociator)
    end

    assert_redirected_to negociators_url
  end
end
