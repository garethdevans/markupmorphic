require File.join(File.dirname(__FILE__), 'page')

class HomePage < Markupmorphic::Page
  def initialize(browser)
    super(browser, 'Home')
  end

  def open
    browser.open(url('/'))
  end

  def login_button
    button(:name, 'login')
  end

end