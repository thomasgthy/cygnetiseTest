# README

This README will describe how I have constructed this technical exercise.
The task was to create a Rails app that will import data from a TV SMS voting campaigns into the
database and display the results by campaigns then candidates.

* Ruby version  
The project has been developed with Ruby 2.4.1 and Rails 5.1.6

* Configuration  
After cloning the repository, you may need to run the following command at the root directory:
```bundle install```

* Database set up  
Following are the steps to set up the database(from the root directory):
```bin/rails db:create```
```bin/rails db:migrate```
```bin/rails data:import``` (This step should take few seconds as the data is heavy)

* How to run the test suite


* Model description  
I choose to define 3 models that will be describe the behavior of the application.
	* Campaign Model  
	The campaign model is responsible of one campaign in the TV SMS vote.
	It stores a unique id and a unique campaign name.

	* Candidate Model  
	The candidate model is responsible of a candidate from one campaign.
	It stores a unique id and a name of the candidate.
	Note that the name of the candidate is not unique  because the same candidate 
	could participate to 2 campaigns.
	There is a has_many association between Campaign and Candidate which means
	1 campaign could have many candidates.

	* Vote Model  
	The vote model is responsible of one vote for a candidate from one campaign.
	It stores a unique id, a validity status, and an epoch time.
	There is a has_many association between Candidate and Vote which means 1 candidate
	could have many votes.

* Controller description  
There is 1 main controller that get the data from the model:
	* Campaign controller which delivers all campaigns and a specific campaign informations to the view.

* View description  
Concerning the view, there are 2 main views:
	* Campaign index view which renders all available campaigns  
	* Campaign show view which renders one of the campaigns. This one is more complex as  
	it includes an additional template rendered in the view. This template comes from the candidate
	show view and renders the content of the vote(candidate name, votes count, uncorrect votes). This template
	rendering splits the view in two: the header of the view which is generic to all campaign and the content of the view which depends on the campaign.

* Parser description  
To parse the log file, I choose to read line by line the txt file and for each line:
	* Validate the encoding of the line
	* Parse the line by space
	* For each part of the parsing, validate the argument
	* Store the data into Campaign, Candidate and Vote tables
To have more informations about the parsing step, please check the comments on the rake task implementation.
You will find it at lib/tasks/data.rake