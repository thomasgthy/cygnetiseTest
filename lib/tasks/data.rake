namespace :data do
  desc "Import data from the log file votes.txt"
  task import: :environment do
  	File.open(Rails.root + "imports/votes.txt", "r") do |file|
		ActiveRecord::Base.transaction do
			file.each_line do |line|
        if ! line.valid_encoding?
          line=line.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
        end
        parseLine(line)
			end
		end
	end
  end

  desc "Delete data imported from votes.txt"
  task drop: :environment do
  end

end

def parseLine(line)
  splitLine=line.split
  vote=splitLine[0]
  epoch_time=splitLine[1]
  campaign=splitLine[2]
  validity=splitLine[3]
  choice=splitLine[4]
  validateVote(vote, epoch_time, campaign, validity, choice)
end

def validateVote(vote, epoch_time, campaign, validity, choice)
  return if vote!="VOTE"
  return if epoch_time.is_a? Integer
  return if campaign.split(':')[0]!="Campaign" || !campaign.split(':')[1].include?("ssss_uk_")
  return if validity.split(':')[0]!="Validity" || !validity.split(':')[1].is_a?(String)
  return if choice.split(':')[0]!="Choice" || !choice.split(':')[1].is_a?(String)
  saveVote(epoch_time, campaign.split(':')[1], validity.split(':')[1], choice.split(':')[1])
end

def saveVote(epoch_time, campaign_name, validity, choice)
  ActiveRecord::Base.transaction do
    campaign=Campaign.find_by(name: campaign_name)
    if !campaign
      campaign=Campaign.create!(name: campaign_name)
    end
    
    candidate=campaign.candidates.find_by(name: choice)
    
    if !candidate
      candidate=campaign.candidates.create!(name: choice)
    end

    candidate.votes.create!(validity: validity, epoch_time: epoch_time)
  end
end