class RegisterPage < Selenium::WebPage
  def initialize(browser)
    super(browser, 'Register')
    @host = 'markupmorphic.com'
  end

  def url(path)
      "http://#{@host}/#{path}"
  end

  def open
    browser.open(url('/user/create'))
  end

  def title
    browser.get_title
  end

  def fill_in_text_field(name, value)
    text_field(:name, name).enter(value)    
  end

  def first_name_field
    text_field(:name, 'first_name')
  end

  def last_name_field
    text_field(:name, 'last_name')
  end

  def email_field
    text_field(:name, 'email')
  end

  def password_field
    text_field(:name, 'password')
  end

  def register_button
    button(:name, 'register')
  end

end