@search
Feature: Search content
  As a Dkit user
  I should be able to search content of any book
  So that I can find information easly

  Background:
    Given student logged in to dkit reader application
    And student open the book

  Scenario: Search content of book
    When student search for a key
    Then search result should not be empty
    And search result snippets contains the key

  Scenario: Search result should be zero when search key not found
    When search for "thisisnotavalidkey"
    Then verify search result is empty

  #Scenario: Search result should be zero when search partial text
    #When student search for a partial key
    #Then verify search result is empty