Feature: Running a test 
  As an iOS developer
  I want to login in my application
  So I can start watching my hero list

@LoginApp
Scenario Outline: Example steps Happy Path
  Given I am on the Login Screen
  Then I fill user "<user>" and password "<password>" fields
  And take picture   
  When I tap over Login button
  Then I see Heroes List screen with "<title>"


Examples:
	| user | password | title       |  
	| bdd  | 1234     | Heroes List |  

