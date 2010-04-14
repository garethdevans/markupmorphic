require File.join(File.dirname(__FILE__), '..', '..', '..', 'lib', 'repository', 'user_repository')
require File.join(File.dirname(__FILE__), '..', '..', '..', 'lib', 'env')


Given /^The system is setup$/ do
  @user_repository = UserRepository.new
  @user_repository.delete_database!
  @user_repository.setup_database!
end

Given /^I visit the home page$/ do
  #visit '/home'
  browser.goto urls.home_url
end

Given /^I visit the register page$/ do
  #visit '/user/create'
  browser.goto urls.signup_url
end

Given /^User id exists for '(.*)'$/ do |email|
  @user_repository = UserRepository.new
  id = @user_repository.find_by_email(email).id
  !id.should.nil? && id.length.should > 0
end

Given /^I fill in '(.*)' for '(.*)'$/ do |value, field|
  #fill_in(field, :with => value)
  browser.text_field(:id, field).set(details[value])
end

When /^I press '(.*)'$/ do |name|
  #click_button(name)
  browser.button(:id, name).click
end

Then /^I should see '(.*)'$/ do |text|
  response_body.should contain(/#{text}/m)
end

When /^I click the link '(.*)'$/ do |name|
  click_link(name)
end
