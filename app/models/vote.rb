class Vote < ApplicationRecord
	validates :validity, presence: true
	validates :epoch_time, presence: true
end
