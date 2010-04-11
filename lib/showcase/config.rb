module Showcase
  class Config
    def initialize(options = {})
      @config = YAML::load(IO.read(config_file)).merge(options)
    end
    
    def description
      @config["description"]
    end
    
    def keywords
      @config["keywords"]
    end
    
    def languages
      @config["languages"]
    end
  
    def resumes_data
      File.join(data_folder, @config["resumes_data"])
    end
  
    def projects_data
      File.join(data_folder, @config["projects_data"])  
    end
  
    def personal_data
      File.join(data_folder, @config["personal_data"]) 
    end
    
    def data_folder
      @config['data_folder']
    end
    
    def google_analytics_code
      if @config["google_analytics_code"] && @config["google_analytics_code"].length > 3
        return @config["google_analytics_code"]
      end
    end
  
    private
    
    def config_file
      File.join(File.dirname(__FILE__), *%w[.. .. config config.yml])
    end
  end
end