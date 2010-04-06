require 'rubygems'
require 'sinatra'

disable :run, :reload
set :environment, :production

require 'showcase.rb'
run Sinatra::Application
