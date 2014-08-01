Feature: DKit User want to download new book

@download
Scenario: As a DKit user I want to Download new book from Library page
        
		 Given student logged in to dkit reader application
		 Then I wait for 10 seconds
         Then user should see the library page
         When student download the book
         Then student should be able to open the book
         * I wait for 5 seconds

@pause_resume_Cancel_download
Scenario: As a DKit user I want to Pause the Downloading Book
          Given student logged in to dkit reader application
          Then I wait for 10 seconds
		  Then user should see the library page
          When student started downloading the book
          When student pause download
          Then student should see download paused
          Then I wait for 10 seconds
          And student resume download
          Then student should be able see downloading after resume
		  Then I wait for 3 seconds
		  And student cancel download
		  Then I should be able to see the book after cancel
		  * I wait for 5 seconds
		  
@remove_Downloaded_book		
Scenario: Remove an existing book
	Given student logged in to dkit reader application
	Then I wait for 10 seconds
	Then user should see the library page
    And student open the book
    Given student go back to Library
    When student remove the book
    Then book should be ready for download
	* I wait for 5 seconds