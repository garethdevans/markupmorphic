Feature: Login
  In order to use the system
  As a normal user
  I want to be able to login on the home page

  Scenario: Create a new user
    Given I visit the register page
    And I fill in 'Bob' for 'first_name'
    And I fill in 'Smith' for 'last_name'
    And I fill in 'bob.smith@lotsofmoney.com' for 'email'
    And I fill in 'password' for 'password'
    When I press 'register'
    Then I should see 'Welcome'


#  Scenario: Login on home page fails when
#    Given I visit the home page
#    And I fill in 'aaa@bbb.com' for 'email'
#    And I fill in 'wrong password' for 'password'
#    When I press 'login'
#    Then I should see 'User or password incorrect'
