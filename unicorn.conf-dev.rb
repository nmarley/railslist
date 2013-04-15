# Minimal sample configuration file for Unicorn (not Rack) when used
# with daemonization (unicorn -D) started in your working directory.
#
# See http://unicorn.bogomips.org/Unicorn/Configurator.html for complete
# documentation.
# See also http://unicorn.bogomips.org/examples/unicorn.conf.rb for
# a more verbose configuration using more features.

# start server with:
# bundle exec unicorn -c unicorn.conf.rb -E development

#listen 7007 # by default Unicorn listens on port 8080
listen "/tmp/unicorn.sock"
worker_processes 2 # this should be >= nr_cpus
approot = "/Users/nmarley/git/railslist"
pid "#{approot}/tmp/pids/unicorn.pid"
stderr_path "#{approot}/log/unicorn.log"
stdout_path "#{approot}/log/unicorn.log"

