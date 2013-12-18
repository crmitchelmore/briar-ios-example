@issue_259
Feature: uia_type_text should not throw octet problems

  Background: i am looking at the text related view
    Given I am looking at the Text tab

  @wip
  Scenario: i should be able to write a bunch of email addresses
    Then I type 1000 email addresses into the text field

