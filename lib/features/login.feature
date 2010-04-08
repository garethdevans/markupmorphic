Feature: Login
  In order to use the system
  As a normal user
  I want to be able to login on the home page

  Scenario: Login on home page fails when
    Given I visit the home page
    And I fill in 'aaa@bbb.com' for 'email'
    And I fill in 'wrong password' for 'password'
    When I press 'login'
    Then I should see 'User or password incorrect'
