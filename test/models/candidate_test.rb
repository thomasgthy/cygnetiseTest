require 'test_helper'

class CandidateTest < ActiveSupport::TestCase
	test "should not save candidate without name" do
	  candidate = Candidate.new
	  assert_not candidate.save
	end

	test "should save candidate without name" do
	  candidate = Candidate.new(name: "candidate_1")
	  assert candidate.save
	end
end
