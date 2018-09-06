module CandidatesHelper
	def votesNumber(candidate)
		candidate.votes.where(validity: "during").count
	end

	def votesPercentage(candidate, campaign)
		(100*candidate.votes.where(validity: "during").count.fdiv(campaign.candidates.sum{|candidate| candidate.votes}.count)).round(2)
	end

	def errorsNumber(candidate)
		candidate.votes.where.not(validity: "during").count
	end

	def errorsPercentage(candidate)
		(100*candidate.votes.where.not(validity: "during").count.fdiv(candidate.votes.count)).round(2)
	end
end
