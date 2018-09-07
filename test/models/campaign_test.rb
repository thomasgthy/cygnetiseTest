require 'test_helper'

class CampaignTest < ActiveSupport::TestCase

	test "should not save campaign without name" do
	  campaign = Campaign.new
	  assert_not campaign.save
	end

	test "should save campaign without name" do
	  campaign = Campaign.new(name: "campaign_1")
	  assert campaign.save
	end
end
