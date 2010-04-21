require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'repository', 'user_repository')
require File.join(File.dirname(__FILE__), '..', '..', 'env')

current_page = nil

Given /^The system is setup$/ do
  user_repository.delete_database!
  user_repository.setup_database!
end

Given /^I visit the home page$/ do
  home_page.open
  current_page = home_page
end

Given /^I visit the register page$/ do
  register_page.open
  current_page = home_page
end

Given /^User id exists for '(.*)'$/ do |email|
  id = user_repository.find_by_email(email).id
  !id.should.nil? && id.length.should > 0
end

Given /^I fill in '(.*)' for '(.*)'$/ do |value, field|
  current_page.fill_in_text_field(field, value)
end

When /^I hit register$/ do
  @register_page.click_register_button
end

Then /^I should see '(.*)'$/ do |text|
  browser.is_text_present(text).should == true
end

When /^I click the link '(.*)'$/ do |name|
  browser.click("link="+name)
end

When /^I hit 'login'$/ do
  @home_page.click_login_button
end
