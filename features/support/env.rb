require 'rubygems'
require 'spec/expectations'

require File.join(File.dirname(__FILE__), '..', '..', 'env')
require File.join(File.dirname(__FILE__), '..', '..', 'main')
require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'repository', 'user_repository')
require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'model', 'user')
require 'selenium'
require 'selenium/client'

# "before all"
#manager = Selenium::ServerManager.new(Selenium::SeleniumServer.new)
#manager.start
browser = Selenium::SeleniumDriver.new("localhost", 4444, "*firefox", "http://markupmorphic.com/", 10000)


Before do
  @browsers = browser
  @browsers.start
end

After do
  @browsers.stop
end

# "after all"
at_exit do
  browser.close rescue nil
  #manager.stop rescue nil
end


class MarkupWorld

  def initialize
    #@verification_errors = []
    #@selenium = Selenium::SeleniumDriver.new("localhost", 4444, "*firefox", "http://markupmorphic.com/", 10000);
    #@selenium.start
    #@selenium.set_context("test_new")
    @host = 'markupmorphic.com'
  end

  def browser
    @browsers
  end

  def host
    @host
  end

  def register_page
    @register_page = RegisterPage.new(browser)
  end

  def home_page
    @home_page = HomePage.new(browser)
  end

  def user_repository
      if not @user_repository
          @user_repository = UserRepository.new
      end
      @user_repository
  end
end

World do
  MarkupWorld.new
end

