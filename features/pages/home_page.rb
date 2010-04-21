require File.join(File.dirname(__FILE__), 'page')

class HomePage < Markupmorphic::Page
  def initialize(browser)
    super(browser, 'Home')
  end

  def open
    browser.open(url('/'))
  end

  def click_login_button
    button(:name, 'login').click_wait
  end

  def click_upload_button
    button(:name, 'upload').click_wait
  end

  def set_email(value)
    text_field(:name, "email").enter(value)
  end

  def set_password(value)
    text_field(:name, "password").enter(value)
  end

  def set_file_name(value)
    text_field(:name, :file_name).enter(value)
  end

end