#require 'capistrano/ext/multistage'
#require 'bundler/capistrano'
#set :bundle_flags, "--local"

default_run_options[:env] = {'PATH' => '/opt/ruby/bin:$PATH'}

set :application, "rails_list"

set :scm, :git
set :repository,  "gitolite@blackcarrot.be:railslist"
set :scm_passphrase, ""

set :user, "deploy"
set :use_sudo, false

#set :stages, %w[staging production]
#set :default_stage, "staging"

server "blackcarrot.be", :app, :web, :db, :primary => true
set :deploy_to, "/var/www/railslist"
set :bundle_without, [:development, :test] # only bundle prod gems

# TODO: use multistage
set :rails_env, :production
# set :unicorn_binary, "/opt/ruby/bin/unicorn"
set :unicorn_cmd, "bundle exec unicorn"
set :unicorn_config, "#{current_path}/unicorn.conf.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{unicorn_cmd} -c #{unicorn_config} -E #{rails_env} -D"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "kill -s TERM `cat #{unicorn_pid}`"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "test -f #{unicorn_pid} && kill -s QUIT `cat #{unicorn_pid}`"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "kill -s USR2 `cat #{unicorn_pid}`"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    graceful_stop
    start
  end
end

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

