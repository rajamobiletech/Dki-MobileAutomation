
Feature: View Table of Content
  As a Dkit user
  I should be able to see table of content of a book
  So that I can navigate to any page

Background:
  Given student logged in to dkit reader application
  And student open the book

Scenario: Show/hide Table of content
  When student press on the table of content button in the header
  Then table of content should display in the page
  When student press on resume reading
  Then the table of content should be hidden
@page_navigation
Scenario: Jump to a particular page from ToC
  Given student opened table of content
  When user navigated to any page from toc

Scenario: Navigate from a bookmarked page to Non bookmarked page
  Given that student open a bookmarked page
  And student opened table of content
  When student navigated to no-bookmarked page from toc
  Then the page should not be bookmarked
  Given student opened table of content
  When student navigated to bookmarked page from toc
  Then the page should be bookmarked





