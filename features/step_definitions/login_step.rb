Given /^I am on the Welcome Screen$/ do
  element_exists("view")
  sleep(STEP_PAUSE)
end

Given /^I am on the Login Screen$/ do
   @login_screen = LoginScreen.new
   @login_screen.wait_for_screen
end

Then /^I fill user "(.*?)" and password "(.*?)" fields$/ do |username, password|
end

When /^I tap over Login button$/ do
end

Then /^I see Heroes List screen with "(.*?)"$/ do |title|
end