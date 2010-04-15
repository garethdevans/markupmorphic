# See http:ab3
#//wiki.github.com/aslakhellesoy/cucumber/sinatra
# for more details about Sinatra with Cucumber

app_file = File.join(File.dirname(__FILE__), *%w[.. .. main.rb])
require app_file
# Force the application name because polyglot breaks the auto-detection logic.
#Sinatra::Application.app_file = app_file




require 'spec/expectations'
require 'rack/builder'
require 'rack/test'
require 'webrat'

Webrat.configure do |config|
  config.mode = :rack
end

class MyWorld
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers

  Webrat::Methods.delegate_to_session :response_code, :response_body


  def initialize
    @builder = Rack::Builder.new
    @builder.use Rack::Session::Cookie, :key => 'rack.session',
                          :path => '/',
                          :expire_after => 60 * 60 * 12, # In seconds
                          :secret => 'change_me'

    @builder.run Main
    @app = @builder.to_app
  end
  

  def app
    @app  
  end

end

require 'firewatir'
require File.join(File.dirname(__FILE__), '..', '..', 'env')

class MarkupWorld
    def browser
        $browser ||= Watir::Browser.new
    end

    def repository
        if not @repository
            @repository = UserRepository.new
            @repository.setup_database!
        end
        @repository
    end

    def urls
        @urls = MarkupWorldUrls.new
    end
end

class MarkupWorldUrls
    def initialize
        @host = 'localhost'
    end

    def site_url(path)
        "http://#{@host}:#{$env[:web_port]}/#{path}"
    end

    def signup_url
        site_url('user/create')
    end

    def home_url
        site_url('')
    end
end

#World do
#    MarkupWorld.new
#end

World{MyWorld.new}
