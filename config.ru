require 'rubygems'
require 'sinatra'

disable :run
set :environment, :production

require 'showcase'
run Sinatra::Application
