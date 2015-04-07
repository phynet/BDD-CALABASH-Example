# require 'calabash-android/operations'
# require 'fileutils'
# require_relative 'android-snapshot'

# INSTALLATION_STATE = {
#   :installed => false
# }

# Before do |scenario|
#   scenario_tags = scenario.source_tag_names

#   if scenario_tags.include?('@reinstall') || !INSTALLATION_STATE[:installed]
#     uninstall_apps
#     install_app(ENV['TEST_APP_PATH'])
#     install_app(ENV['APP_PATH'])
#     INSTALLATION_STATE[:installed] = true
#     $logged_in = false
#   end

#   @time = DateTime::now::strftime("%H:%M:%S")

#   #take screenshot for every scenario 
#   case scenario
#     when Cucumber::Ast::Scenario
#       feature_title = scenario.feature.title
#       scenario_name = scenario.name
#       example = "/"

#     when Cucumber::Ast::ScenarioOutline
#       feature_title = scenario.feature.title
#       scenario_name = scenario.name
#       example = "#{scenario.map.entries[0].value}/"

#     when Cucumber::Ast::OutlineTable::ExampleRow
#       feature_title = scenario.scenario_outline.feature.title
#       scenario_name = scenario.scenario_outline.name
#       example = "#{scenario.map.entries[0].value}/"
#   end

#   # Trim scenario name
#   position = scenario_name.index(" - ")
#   scenario_name = scenario_name.slice(0, position)

#   image = "output/screenshots/android/passed_scenarios/#{feature_title}/#{scenario_name}/#{test_start_time}/#{@time}-#{example}"
#   failed_image = "output/screenshots/android/failed_scenarios/#{feature_title}/#{scenario_name}/#{test_start_time}/#{@time}-#{example}"

#   @step_count = 0
#   $screenshot = AndroidSnapshooter.new(self, image, failed_image)
# end

# AfterStep do |scenario|
#   if scenario.instance_of? Cucumber::Ast::OutlineTable::ExampleRow
#     scenario = scenario.scenario_outline
#   end

#   # call method 'steps' and select the current step
#   # we use .send because the method 'steps' is private for scenario outline
#   step_title = scenario.send(:steps).to_a[@step_count].name

#   $screenshot.save_step_image step_title

#   # increase step counter
#   @step_count += 1
# end

# After do |scenario|
#   if (scenario.failed?)
#     $screenshot.save_fail_image
#   end
# end