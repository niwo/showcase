#!/usr/bin/env ruby

# Showcase Portfolio and Resume -Webapplication
# (C) 2010 Nik Wolfgramm

require 'rubygems'
require 'rack/cache'
require 'sinatra'
require 'yaml'
require 'haml'
require 'maruku'
require 'sinatra/r18n'
 
set :haml, {:format => :html5 }

# activate rack-cache in production
configure :production do
  use Rack::Cache, 
    :verbose => true, 
    :metastore => "file:cache/meta", 
    :entitystore => "file:cache/body"
end
 
before do
  headers "Content-Type" => "text/html; charset=utf-8"
  response["Cache-Control"] = "max-age=300, public"
end

PAGES = {'home' => '/', 'resume' => '/resume/', 'portfolio' => '/portfolio/'}

helpers do
  def language_select(page)
    lang_sel = ""    
    r18n.available_locales.each do |locale| 
      lang_sel += r18n.locale.code == locale.code ? locale.title  : "<a href='/#{locale.code}#{PAGES[page]}'>#{locale.title}</a>"
      lang_sel += " | " unless( locale.code == r18n.available_locales[-1].code)
    end
    lang_sel
  end
  
  def menu_links(page)
    menu = ""
    n = 1
    PAGES.each_pair do |name, link|
      menu += (page == name) ? t.showcase.send(name) : "<a href='/#{r18n.locale.code}#{link}'>#{t.showcase.send(name)}</a>"
      menu += " | " unless( PAGES.size == n)
      n += 1
    end
    menu
  end
  
  def text_with_line_breaks(text)
    text.gsub("\n", "<br />")
  end
  
  def obscure_email(email)
    return nil if email.nil?
    lower = ('a'..'z').to_a
    upper = ('A'..'Z').to_a
    email.split('').map { |char|
        output = lower.index(char) + 97 if lower.include?(char)
        output = upper.index(char) + 65 if upper.include?(char)
        output ? "&##{output};" : (char == '@' ? '&#0064;' : char)
    }.join
  end
end

get '/:locale?/?' do
  @page = 'home'
  haml :index
end
 
get '/:locale/resume/?' do
  @page = 'resume'
  resumes = YAML.load_file( './data/resumes.yml' )
  @personal = YAML.load_file( './data/personal.yml' )
  @language = r18n.locale.code
  @page_title = resumes[@language]['title']
  @resume_data = resumes[@language]
  @resume = Maruku.new(File.open(@resume_data['file']).read).to_html.gsub(/^\s*\n/, "")
  haml :resume
end
 
get '/:locale/portfolio/?' do
  @page = 'portfolio'
  @page_title = "Project Portfolio"
  @projects = YAML.load_file( './data/projects.yml' )
  haml :portfolio
end