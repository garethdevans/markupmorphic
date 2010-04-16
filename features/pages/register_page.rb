require File.join(File.dirname(__FILE__), 'page')

class RegisterPage < Markupmorphic::Page
  def initialize(browser)
    super(browser, 'Register')
  end

  def open
    browser.open(url('/user/create'))
  end

  def register_button
    button(:name, 'register')
  end

end