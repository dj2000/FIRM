namespace :update_bid do
  task :balance => :environment do
    Bid.all.each do |bid|
      bid.save_balance
      bid.save
    end
  end
end