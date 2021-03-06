# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "log/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
#set :environment, "ENV['RAILS_ENV']"
every 1.day, :at => '10:00 pm' do
	dir = File.expand_path('../../', __FILE__)
	command "cd #{dir} && bundle exec backup perform --trigger db_backup --config-file #{dir}/config/Backup/config.rb"
end