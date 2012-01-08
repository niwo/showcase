#!/usr/bin/env ruby

# Showcase: a portfolio and resume web application based on Sinatra
# (C) 2011 Nik Wolfgramm

require 'rubygems'
require 'sinatra'
require 'sinatra/r18n'
require 'rack/cache'
require 'rack/contrib'  
require 'haml'
require File.join("./lib", "showcase")
 
# set haml fromat to html5
set :haml, {:format => :html5 }

# load Showcase application settings and data
SC = Showcase::Application.new

# activate rack-cache and contrib in production
configure :production do
  use Rack::Cache, 
    :verbose => true,
    :metastore => "file:cache/meta", 
    :entitystore => "file:cache/body"
  use Rack::StaticCache,
    :urls => ['/stylesheets', '/images', 'images/projects', 'images/personal', 'images/nivo-slider', '/javascripts'],
    :root => "public",
    :duration => 1
end
 
before do
  headers "Content-Type" => "text/html; charset=utf-8"
  response["Cache-Control"] = "max-age=300, public"
end

helpers do  
  def language_select(page_name)
    lang_sel = ""    
    r18n.available_locales.each do |locale|
      if SC.config.languages.include? locale.code
        lang_sel += r18n.locale.code == locale.code ? locale.title : "<a href='/#{locale.code}#{SC.page(page_name).path}'>#{locale.title}</a>"
        lang_sel += " | " unless( locale.code == r18n.available_locales.last.code)
      end
    end
    lang_sel
  end
  
  def menu_links(page_name)
    menu = []
    SC.pages.each do |page|
      menu << (page.name == page_name ? "<span class='current'>#{t.showcase.send(page.name)}</span>" : "<a href='/#{r18n.locale.code}#{page.path}'>#{t.showcase.send(page.name)}</a>")
    end
    menu
  end
  
  def text_with_line_breaks(text)
    text.gsub("\n", "<br />")
  end
  
  # convert characters to html entities
  def obscure_email(email)
    return nil if email.nil? #Don't bother if the parameter is nil.
    lower = ('a'..'z').to_a
    upper = ('A'..'Z').to_a
    email.split('').map { |char|
        output = lower.index(char) + 97 if lower.include?(char)
        output = upper.index(char) + 65 if upper.include?(char)
        output ? "&##{output};" : (char == '@' ? '&#0064;' : char)
    }.join
  end
end

get '/vcard.vcf' do
  content_type :vcf
  @me = SC.me
  erb :vcard
end

['/', '/:locale/?'].each do |path|
  get path do
    @page = 'home'
    @me = SC.me
    @page_title = "Showcase #{t.showcase.home}"
    haml :index
  end
end
 
get '/:locale/resume/?' do
  @page = 'resume'
  @me = SC.me
  @language = r18n.locale.code
  @resume = SC.resume(@language)
  @page_title = @resume.title
  haml :resume
end
 
get '/:locale/portfolio/?' do
  @page = 'portfolio'
  @page_title = t.showcase.portfolio
  @projects = SC.projects
  haml :portfolio
end