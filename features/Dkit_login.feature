Feature: Login with user credentials

  @login
  Scenario: User Login with valid credentials
    Given Valid User want to login to the Application
   # When user on login page
    When user login with valid credentials
   # Then I wait for 10 seconds
    Then user should see the library page
   # Then I wait for 5 seconds
