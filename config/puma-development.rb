# config/puma.rb

# start server with:
# puma -C config/puma.rb

bind 'unix:///tmp/puma.sock'
threads 0, 16
workers 4
approot = '/Users/nmarley/git/railslist'
pidfile "/tmp/puma.pid"
stdout_redirect '/tmp/puma.log', '/tmp/puma.err', true
environment 'development'
daemonize
#user "deploy", "deploy"

on_worker_boot do
  require "active_record"
  #cwd = File.dirname(__FILE__)+"/.."
  #ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  #ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"] || YAML.load_file("#{cwd}/config/database.yml")[ENV["RAILS_ENV"]])
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

preload_app!
