require 'rubygems'
require 'populator'
require 'faker'
require 'random_data'

# rake app:setup

namespace :app do
  desc "Add a nested index."
  task :setup => :environment do
   puts "Started with task to populate demo data for Property"
   streets = ["Street1", "Street2"]
   client_first_name = ["ClientA", "ClientB"]
   agent_first_name = ['AgentA', 'AgentB']
   Property.delete_all
   
   streets.each_with_index do |street_name|
			Property.populate(5) do |prop|     
		 	 	prop.street = street_name
		 	 	prop.zip = Random.zipcode
		 	end
		end

		puts "Started with task to populate demo data for Client"
		Client.delete_all
		client_first_name.each_with_index do |client_name|
			Client.populate(5) do |client|     
		 	 	client.firstName = client_name
		 	end
		end

		puts "Started with task to populate demo data for Agent"
   	Agent.delete_all
		agent_first_name.each_with_index do |agent_name|
			Agent.populate(5) do |agent|     
		 	 	agent.firstName = agent_name
		 	end
		end
 	end
end
