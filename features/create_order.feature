Feature:
  As a registered user
  I want to be able to create an order
  So that I can have it processed into lovely html

  Scenario:
    Given a logged in registered user on the home page
    And I select a psd file called 'test_file.psd' to upload
    And I hit upload
    Then I should see 'order created'