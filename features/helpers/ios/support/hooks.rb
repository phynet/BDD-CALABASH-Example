require 'calabash-cucumber/operations'
require 'fileutils'
require_relative 'ios-snapshot'

INSTALLATION_STATE = {
  :installed => false
}

Before do |scenario|

  scenario_tags = scenario.source_tag_names

  if (scenario_tags.include?('@reinstall'))
    if !device
      Calabash::Cucumber::Launcher.new.reset_app_jail
    else
       app_path = ENV['APP_BUNDLE_PATH']
      # %x(ios-deploy --uninstall --debug --bundle #{app_path} 2>&1)
      # %x(ios-deploy --debug --bundle #{app_path.gsub(/\.app/, '.ipa')} 2>&1)
    end
    $logged_in = false
  end

  @time = DateTime::now::strftime("%H:%M:%S")

  #take screenshot for every scenario
  case scenario
    when Cucumber::Ast::Scenario
      feature_title = scenario.feature.title
      scenario_name = scenario.name
      example = "/"

    when Cucumber::Ast::ScenarioOutline
      feature_title = scenario.feature.title
      scenario_name = scenario.name
      example = "#{scenario.map.entries[0].value}/"

    when Cucumber::Ast::OutlineTable::ExampleRow
      feature_title = scenario.scenario_outline.feature.title
      scenario_name = scenario.scenario_outline.name
      example = "#{scenario.map.entries[0].value}/"
  end

  @step_count = 0
end

AfterStep do |scenario|
  if scenario.instance_of? Cucumber::Ast::OutlineTable::ExampleRow
    scenario = scenario.scenario_outline
  end

  # call method 'steps' and select the current step
  # we use .send because the method 'steps' is private for scenario outline
  step_title = scenario.send(:steps).to_a[@step_count].name

  p step_title


end

After do |scenario|
  if (scenario.failed?)
    #$screenshot.save_fail_image
  end
end