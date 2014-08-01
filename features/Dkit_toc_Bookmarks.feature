@toc_bookmark
  Feature: Edit Bookmark Title
    As a Dkit user
    I should be able to edit bookmark title in table of content of a book
    So that I can see the edited bookmark title

  Background:
    Given student logged in to dkit reader application
    And student open the book

@edit_title
  Scenario: Edit Bookmark Title
    When student press on the table of content button in the header
    Then table of content should display in the page
    When student open Bookmark icon from toc
    Then the list of bookmark pages link should be open
    #Then I press Edit title
    #And  I update the title "New title"
    #Then I press Save title
    #Then I should be able to see the updated title

#@remove_bookmark
 # Scenario: Remove Bookmark From TOC
   # When student press on the table of content button in the header
   # Then table of content should display in the page
   # When student open Bookmark icon from toc
   # Then the list of bookmark pages link should be open
   # And I press Remove title
   # Then the Bookmark should be removed in the list