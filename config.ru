require 'application'

log = File.new("log/showcase.log", "a")
$stdout.reopen(log)
$stderr.reopen(log)

run Sinatra::Application