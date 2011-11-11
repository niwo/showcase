require File.join( File.dirname(__FILE__), 'application')

log = File.new( File.join( File.dirname(__FILE__), "log", "showcase.log"), "a")
$stdout.reopen(log)
$stderr.reopen(log)

run Sinatra::Application