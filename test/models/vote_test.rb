require 'test_helper'

class VoteTest < ActiveSupport::TestCase
	test "should not save vote without epoch_time, validity" do
	  vote = Vote.new
	  assert_not vote.save
	end

	test "should save campaign without title" do
	  vote = Vote.new(epoch_time: "123476193", validity: "during")
	  assert vote.save
	end
end
