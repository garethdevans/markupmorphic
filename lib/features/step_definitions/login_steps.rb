require File.join(File.dirname(__FILE__), '..', '..', '..', 'lib', 'repository', 'user_repository')

Given /^The system is setup$/ do
  @user_repository = UserRepository.new
  @user_repository.setup_database!
end

Given /^I visit the home page$/ do
  visit '/home'
end

Given /^I visit the register page$/ do
  visit '/user/create'
end

Given /^I fill in '(.*)' for '(.*)'$/ do |value, field|
  fill_in(field, :with => value)
end

When /^I press '(.*)'$/ do |name|
  click_button(name)
end

Then /^I should see '(.*)'$/ do |text|
  response_body.should contain(/#{text}/m)
end
