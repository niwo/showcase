require 'rdiscount'

module Showcase
  class Resume
    attr_reader :lang
    attr_reader :file
    attr_reader :title
    attr_reader :updated_at
  
    def initialize(lang, file, opts = {})
      @lang = lang 
      @file = file || "/data/resume.#{lang}.md"
      @updated_at = opts[:updated_at] || Time.now
      @title = opts[:title] || nil
    end
  
    def content
      RDiscount.new(File.open(@file).read).to_html rescue "<p>#{@file} not found or empty</p>"
    end
  end
  
  class Page
    attr_reader :name
    attr_reader :path
  
    def initialize(name, path=nil)
      @name = name
      @path = path || "/#{@name}/"
    end
  end
end