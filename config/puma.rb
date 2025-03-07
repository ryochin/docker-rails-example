require 'fileutils'

# Specify the bind host and environment.
bind "tcp://0.0.0.0:#{ENV.fetch("PORT") { "8000" }}"
environment ENV.fetch("RAILS_ENV") { "production" }

app_root = File.expand_path('..', __dir__)
FileUtils.mkdir_p "#{app_root}/tmp/sockets"
bind "unix://#{app_root}/tmp/sockets/puma.sock"

# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes). It defaults to the number of (virtual cores * 2).
workers = ENV.fetch("WEB_CONCURRENCY") { Etc.nprocessors * 2 }

# Specifies the `worker_timeout` threshold that Puma will use to wait before
# terminating a worker in development environments.
worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
preload_app!

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart
