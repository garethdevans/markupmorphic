require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'repository', 'user_repository')
require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'model', 'user')

Given /^a logged in registered user on the home page$/ do
  user_repository.delete_database!
  user_repository.setup_database!
  @user = User.new({:first_name=>"Bob", :last_name=>"Smith",:email=>"bob@yahoo.com",:password=>"password"})
  user_repository.save(@user)
  home_page.open
  home_page.set_email("bob@yahoo.com")
  home_page.set_password("password")
  home_page.click_login_button
end

When /^I select a psd file called '(.*)' to upload$/ do |file_name|
  test_data = File.join(File.dirname(__FILE__), '..', 'test_data')
  file_path = File.join(test_data, file_name)
  home_page.set_file_name(file_path)
end

When /^I hit upload$/ do
  home_page.click_upload_button
end

