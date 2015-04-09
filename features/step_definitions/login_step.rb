Given /^I am on the Login Screen$/ do
   @login_screen = LoginScreen.new
   @login_screen.wait_for_screen
end

Then /^I fill user "(.*?)" and password "(.*?)" fields$/ do |username, password|
	@login_screen.fill_input(username,:username)
	@login_screen.fill_input(password, :password)
end

When /^I tap over Login button$/ do
	@login_screen.sign_in
end

Then /^I see Heroes List screen with "(.*?)"$/ do |title|
	@dashboard_screen = DashboardScreen.new
	@dashboard_screen. wait_for_screen
	@dashboard_screen.check_screen(title)
end