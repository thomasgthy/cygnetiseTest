class Campaign < ApplicationRecord	
	has_many :candidates

	validates :name, presence: true
end
