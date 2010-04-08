# See http:ab3
#//wiki.github.com/aslakhellesoy/cucumber/sinatra
# for more details about Sinatra with Cucumber

app_file = File.join(File.dirname(__FILE__), *%w[.. .. main.rb])
require app_file
# Force the application name because polyglot breaks the auto-detection logic.
Sinatra::Application.app_file = app_file



require 'spec/expectations'
require 'rack/test'
require 'webrat'

Webrat.configure do |config|
  config.mode = :rack
end

class MyWorld
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers

  def app
    #Sinatra::Application
    Main
  end
end

World{MyWorld.new}
