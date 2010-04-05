require "rubygems"

# using vendored gems as needed on dreamhost
require "vendor/sinatra/lib/sinatra"
require "vendor/haml/lib/haml"
require "vendor/maruku/lib/maruku"
require "vendor/rack-cache/lib/rack/cache"
require "vendor/sinatra-r18n/lib/sinatra/r18n"

set :run, false
set :environment, :production

require "showcase.rb"
run Sinatra::Application
