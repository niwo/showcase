require 'rubygems'
require 'sinatra'

disable :run, :reload
set :environment, :production

ENV['GEM_PATH'] = '/home/niwo/gems'
Gem.clear_paths

require 'showcase.rb'
run Sinatra::Application
