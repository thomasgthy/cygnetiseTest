require 'test_helper'
require 'candidates_helper'

class CandidatesHelperTest < ActionDispatch::IntegrationTest
  include CandidatesHelper
  #Set up the db for our tests
  setup do
    @campaign=Campaign.new(name: "campaign_1")
    @candidate=@campaign.candidates.new(name: "candidate_1")
    @campaign.save!
    @candidate.votes.create!(epoch_time: "12345678", validity: "during")
  end

  # Test the votesNumber helper method
  test "should get correct votes number" do
    assert_equal(1, votesNumber(@candidate))
  end

  # Test the votesPercentage helper method
  test "should get correct votes percentage" do
    assert_equal(100.0, votesPercentage(@candidate, @campaign))
  end

  # Test the errorsNumber helper method
  test "should get correct errors number" do
    @candidate.votes.create!(epoch_time: "12345622", validity: "post")
    @candidate.votes.create!(epoch_time: "12345634", validity: "pre")
    assert_equal(2, errorsNumber(@candidate))
  end

  # Test the errorsPercentage helper method
  test "should get correct errors percentage" do
    @candidate.votes.create!(epoch_time: "12345622", validity: "post")
    @candidate.votes.create!(epoch_time: "12345634", validity: "pre")
    assert_equal(66.67, errorsPercentage(@candidate))
  end
end
