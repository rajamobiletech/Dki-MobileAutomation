@bookmarks
Feature: Add and remove bookmark
         As a dkit user
         I should be able to add or remove bookmark a particular page
         So that I can refer it later

Background:
    Given student logged in to dkit reader application
    And student open the book
    Then student turn next page

@Add_Remove_Bookmark
Scenario: Add/remove bookmark to a page
    Given that student open non bookmarked page
    When student taps the bookmark tag
    Then the page should be bookmarked
    When student turn previous page
    And student turn next page
    Then the page should be bookmarked
    When student taps the bookmark tag
    Then the page should not be bookmarked

@view_Bookmark
Scenario: Bookmark should remain when the user reopen the book
    Given that student open non bookmarked page
    When student taps the bookmark tag
    And user go back to Library
    And student open the book
    Then the page should be bookmarked
    When taps the bookmark tag
    Then the page should not be bookmarked