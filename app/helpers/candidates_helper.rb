module CandidatesHelper
	# Get a count of all votes for one candidate
	def votesNumber(candidate)
		candidate.votes.where(validity: "during").count
	end

	# Get a percentage of votes for one candidate
	def votesPercentage(candidate, campaign)
		(100*candidate.votes.where(validity: "during").count.fdiv(campaign.candidates.sum{|candidate| candidate.votes}.count)).round(2)
	end

	# Get a count of all errors vote for one candidate
	def errorsNumber(candidate)
		candidate.votes.where.not(validity: "during").count
	end

	# Get a percentage of votes for one candidate
	def errorsPercentage(candidate)
		(100*candidate.votes.where.not(validity: "during").count.fdiv(candidate.votes.count)).round(2)
	end
end
