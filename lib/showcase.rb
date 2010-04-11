require 'yaml'
require 'ostruct'

# require local showcase dependencies
require File.join(File.expand_path(File.dirname(__FILE__)), "showcase", "models")
require File.join(File.expand_path(File.dirname(__FILE__)), "showcase", "config")

module Showcase
  VERSION = '0.2'
  
  class Application
    attr_reader :config
    
    def initialize(options = {})
      @config = Config.new(options)
      @resumes  = {}
      @projects = []
      load_data()      
    end
  
    def resume(lang)
      @resumes[lang]
    end
  
    def projects
      @projects
    end
  
    def me
      @me
    end
    
    def pages
      @pages ||= [Page.new('home', '/'), Page.new('resume'), Page.new('portfolio')]
    end
    
    def page(name)
      pages.map {|page| return page if page.name == name}
    end
  
    private
  
    def load_data
      load_resumes()
      load_projects()
      load_personal()
    end
  
    def load_resumes
      resumes = YAML.load_file(@config.resumes_data) || {}
      resumes.each do |lang, resume|
        @resumes[lang] = Resume.new(lang, resume['file'],
          {:updated_at => resume['updated_at'], :title => resume['title']})
      end
    end
  
    def load_projects
      projects = YAML.load_file(@config.projects_data)
      projects.each do |key, project|
        id = {:id => key}
        @projects << OpenStruct.new(project.merge(id))
      end
    end
  
    def load_personal
      me = YAML.load_file(@config.personal_data)
      @me = OpenStruct.new(me)
    end
  end
end