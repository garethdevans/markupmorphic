require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'repository', 'user_repository')
require File.join(File.dirname(__FILE__), '..', '..', 'env')


Given /^The system is setup$/ do
  user_repository.delete_database!
  user_repository.setup_database!
end

Given /^I visit the home page$/ do
  browser.open urls.home_url
end

Given /^I visit the register page$/ do
  register_page.open
end

Given /^User id exists for '(.*)'$/ do |email|
  id = user_repository.find_by_email(email).id
  !id.should.nil? && id.length.should > 0
end

Given /^I fill in '(.*)' for '(.*)'$/ do |value, field|
  register_page.fill_in_text_field(field, value)
end

When /^I hit register$/ do
  register_page.register_button.click_wait
end

When /^I press '(.*)'$/ do |name|
  browser.button(:name, name).click_wait
end

Then /^I should see '(.*)'$/ do |text|
  #response_body.should contain(/#{text}/m)
  browser.is_text_present(text).should == true
end

When /^I click the link '(.*)'$/ do |name|
  browser.click("link="+name)
end