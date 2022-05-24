require "test_helper"

class AlpacasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get alpacas_index_url
    assert_response :success
  end
end
