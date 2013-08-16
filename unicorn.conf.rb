# start server with:
# unicorn -c unicorn.conf.rb -E production -D

listen "/tmp/unicorn.sock"
worker_processes 8 # this should be >= nr_cpus
approot = "/var/www/railslist"
pid "#{approot}/shared/pids/unicorn.pid"
stderr_path "#{approot}/shared/log/unicorn.log"
stdout_path "#{approot}/shared/log/unicorn.log"
user "deploy", "deploy"
