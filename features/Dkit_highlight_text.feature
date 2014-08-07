
Feature: Highlighted text scenarios in the selected book

Background:
  Given student logged in to dkit reader application
  And student open the book
  #Then I wait for 5 seconds
  
@Add_highlight_text
Scenario: Highlight Text
  Given that student open any page in the selected book
  When student highlight first sentence in the page
  Then first sentence should be highlighted in the page
  
@Update_highlight_text
Scenario: Update Highlight
  Given that student open any page in the selected book
  And student highlight first sentence in the page
  When student extend the highlight
  Then verify that the highlight is extended

@Remove_highlight
Scenario: Remove highlighted text
  Given that student open any page in the selected book
  When student highlighted title of the page
  Given title should be highlighted in the page
  When student remove highlight from title
  Then title is not highlighted in the page



