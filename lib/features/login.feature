Feature: User
  In order to use the system
  As a normal user
  I want to be able to create a new user and login

  Scenario: Create a new user
    Given The system is setup
    And I visit the register page
    And I fill in 'Bob' for 'first_name'
    And I fill in 'Smith' for 'last_name'
    And I fill in 'bob.smith@lotsofmoney.com' for 'email'
    And I fill in 'password' for 'password'
    When I press 'register'
    Then I should see 'Sign out'

  Scenario: Login with new user
    Given User id exists for 'bob.smith@lotsofmoney.com'
    And I visit the home page
    And I fill in 'bob.smith@lotsofmoney.com' for 'email'
    And I fill in 'password' for 'password'
    When I press 'login'
    Then I should see 'Sign out'


