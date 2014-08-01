Feature: DKit User I want to see the Dkit app setting's
@dkit_settings_about_page
Scenario: Setting's verification from the Library Page
         Given student logged in to dkit reader application
		 Then I wait for 10 seconds
         Then user should see the library page
         Then I open setting's from library page
#		 When Iam on Settings screen
		 Then I open About from setting's page
         Then I should be able to see the version page
         Then I open the privacy page
         Then I press back button
		 Then I wait for 10 seconds
		 Then I should be able to see the version page
         Then I open the legal page
         Then I press back button
		 Then I wait for 10 seconds
		 Then I should be able to see the version page
         Then I close the About page from setting's
		 Then I wait for 10 seconds
		 Then user should see the library page

@dkit_settings_manage_devices
Scenario: Setting's Manage Device's verification from the Library Page
          Given student logged in to dkit reader application
          Then I wait for 10 seconds
          Then user should see the library page
          Then I open setting's from library page
	      Then I open Manage Devices
          Then I should be able to see the de-register devices page
          Then I select one device for de-register
          Then I check the device has de-registered
          Then I select close de-register devices page

@dkit_settings_preferences
Scenario: To Verify the Preferences settings in Dkit app
          Given student logged in to dkit reader application
          Then user should see the library page
          Then I open setting's from library page
		  Then I open preferences
		  Then I wait for 10 seconds
          Then I enable page preview from preferences
          Then I close the preference
		  Then I wait for 5 seconds

@dkit_deregister_settings
Scenario: Deregister from the Dkit app
          Given student logged in to dkit reader application
          Then user should see the library page
          Then I open setting's from library page
		  Then I select derigester icon
        # Then I check is deregistered
		  Then I wait for 15 seconds
		  When user on login page

@dkit_user_display
Scenario: To Verify the User Name In settings Page
          Given student logged in to dkit reader application
          Then user should see the library page
          Then I open setting's from library page
		  When Iam on Settings screen
		# Then I check the user name
