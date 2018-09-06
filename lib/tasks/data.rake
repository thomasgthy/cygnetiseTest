namespace :data do
  desc "Import data from the log file votes.txt"
  task import: :environment do
    #Open the file in read only mode
  	File.open(Rails.root + "imports/votes.txt", "r") do |file|
  		ActiveRecord::Base.transaction do
  			file.each_line do |line|
          #If line is not encoded right, encode it in UTF-8
          if ! line.valid_encoding?
            line=line.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
          end
          #Call the method to parse the line
          parseLine(line)
  			end
  		end
	  end
  end
end

def parseLine(line)
  #Parse the line
  splitLine=line.split
  vote=splitLine[0]
  epoch_time=splitLine[1]
  campaign=splitLine[2]
  validity=splitLine[3]
  choice=splitLine[4]
  #Call the method to validate the vote
  validateVote(vote, epoch_time, campaign, validity, choice)
end

def validateVote(vote, epoch_time, campaign, validity, choice)
  #Validate the line by checking each argument
  return if vote!="VOTE"
  return if epoch_time.is_a? Integer
  return if campaign.split(':')[0]!="Campaign" || !campaign.split(':')[1].include?("ssss_uk_")
  return if validity.split(':')[0]!="Validity" || !validity.split(':')[1].is_a?(String)
  return if choice.split(':')[0]!="Choice" || !choice.split(':')[1].is_a?(String)
  saveVote(epoch_time, campaign.split(':')[1], validity.split(':')[1], choice.split(':')[1])
end

def saveVote(epoch_time, campaign_name, validity, choice)
  #Do the saving part into a transaction to keep the data consistent
  ActiveRecord::Base.transaction do
    #Check if the campaign already exists
    campaign=Campaign.find_by(name: campaign_name)
    #If not, create a new campaign
    if !campaign
      campaign=Campaign.create!(name: campaign_name)
    end
    #Check if the candidate for this campaign already exists
    candidate=campaign.candidates.find_by(name: choice)
    #If not, create a new candidate for this campaign
    if !candidate
      candidate=campaign.candidates.create!(name: choice)
    end
    #Create a new vote
    candidate.votes.create!(validity: validity, epoch_time: epoch_time)
  end
end