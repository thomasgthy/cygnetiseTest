require 'test_helper'

class CampaignsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @campaign = campaigns(:one)
  end

  test "should get index" do
    get campaigns_index_path
    assert_response :success
  end

  test "should show campaign" do
    get campaign_path(@campaign)
    assert_response :success
  end

end
