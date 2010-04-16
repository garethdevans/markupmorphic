module Markupmorphic
  class Page < Selenium::WebPage
    def initialize(browser, name)
      super(browser, name)
    end

    def host
      @host = 'markupmorphic.com'
    end

    def url(path)
        "http://#{host}/#{path}"
    end

    def fill_in_text_field(name, value)
      text_field(:name, name).enter(value)
    end    
  end
end
