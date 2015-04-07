# require 'calabash-cucumber/operations'
# require 'fileutils'
# require_relative 'ios-snapshot'

# INSTALLATION_STATE = {
#   :installed => false
# }

# Before do |scenario|

#   scenario_tags = scenario.source_tag_names

#   if (scenario_tags.include?('@reinstall'))
#     if !device
#       Calabash::Cucumber::Launcher.new.reset_app_jail
#     #Añadir cuando intentemos lanzar con el dispositivo físico. Por ahora comentado.
#     #else 
#       # app_path = ENV['APP_BUNDLE_PATH']
#       # %x(ios-deploy --uninstall --debug --bundle #{app_path} 2>&1)
#       # %x(ios-deploy --debug --bundle #{app_path.gsub(/\.app/, '.ipa')} 2>&1)
#     end
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

#   image = "output/screenshots/ios/passed_scenarios/#{feature_title}/#{scenario_name}/#{test_start_time}/#{@time}-#{example}"
#   failed_image = "output/screenshots/ios/failed_scenarios/#{feature_title}/#{scenario_name}/#{test_start_time}/#{@time}-#{example}"

#   @step_count = 0
#   $screenshot = IosSnapshooter.new(self, image, failed_image)
# end

# AfterStep do |scenario|
#   if scenario.instance_of? Cucumber::Ast::OutlineTable::ExampleRow
#     scenario = scenario.scenario_outline
#   end

#   # call method 'steps' and select the current step
#   # we use .send because the method 'steps' is private for scenario outline
#   step_title = scenario.send(:steps).to_a[@step_count].name

#   p step_title

#   $screenshot.save_step_image step_title

#   # increase step counter
#   @step_count += 1
# end

# After do |scenario|
#   if (scenario.failed?)
#     $screenshot.save_fail_image
#   end
# end