require "rvm/capistrano"
set :application, 'firm'
set :scm, :git
set :branch, "master"
set :repo_url, 'https://github.com/dj2000/FIRM.git'
set :deploy_to, "/home/webwerks/deployment/firm"
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'public/pdfs')
# specify how many releases Capistrano should store on server's harddrive
set :keep_releases, 5
set :rvm_ruby_string, '2.2.1@firm'
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# set :deploy_to, '/var/www/my_app'
# set :scm, :git

# set :format, :pretty
set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

set :rvm_ruby_string, :local
set :rvm_type, :system

task :update_rvm do 
  run "rvm install 1.9.2"
  run "rvm use 2.2.1@firm --create"
end
namespace :deploy do

  desc "Symlink shared config files"
  task :symlink_config_files do
    run "#{ try_sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
  end
end
before 'deploy', 'update_rvm'
after :deploy, "deploy:migrate"
#after :finishing, 'deploy:cleanup"
