
Feature: Checking Notes scenarios for selected book

  Background:
    Given student logged in to dkit reader application
    And student open the book
    Then I wait for 5 seconds

@Add_Note_text
  Scenario: Add a note to text
    Given that student open any page in the selected book
    When student add note "First note" to first sentence in the page
    Then first sentence has note as "First note"

@Add_note_for_highlighted_title_text
  Scenario: Add note to a already highlighted text
    Given that student open any page in the selected book
    When student highlighted title of the page
    And student add note "Second note" to title
    Then title has note as "Second note"

  @Add_note_without_enter_text_title
  Scenario: Add note without entering text
    Given that student open any page in the selected book
    When student remove highlight from title
    And student add note "" to title
    Then verify title has no highlighted text

  @Update_note
  Scenario: Update a note
    Given that student open any page in the selected book
  #  And student add note "Second note to title " to title
    When student update note "Update second note" to title
    Then title has note as "Updated second note"

  @remove_note
  Scenario: Remove an existing note by remove highlight
    Given that student open any page in the selected book
   # And student add note "Second note to title" to title
    Given that the page has title
    When student remove highlight from title
    Then title is not highlighted in the page

  @remove_note_from_note_screen
  Scenario: Remove an existing note from note screen
    Given that the page has title
    When student open note and delete
    Then verify title has no highlighted note
    But title should be highlighted in the page