#require 'capistrano/ext/multistage'
#require 'bundler/capistrano'
#set :bundle_flags, "--local"

default_run_options[:env] = {'PATH' => '/opt/ruby/bin:$PATH'}

set :application, "rails_list"

set :scm, :git
set :repository,  "gitolite3@blackcarrot.be:railslist"
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
# set :puma_binary, "/opt/ruby/bin/puma"
set :puma_cmd, "bundle exec puma"
set :puma_config, "#{current_path}/config/puma.rb"
set :puma_pid, "#{current_path}/tmp/pids/puma.pid"

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{puma_cmd} -C #{puma_config}"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "test -f #{puma_pid} && kill -s TERM `cat #{puma_pid}`"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "test -f #{puma_pid} && kill -s QUIT `cat #{puma_pid}`"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "kill -s USR2 `cat #{puma_pid}`"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    graceful_stop
    start
  end
end

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

