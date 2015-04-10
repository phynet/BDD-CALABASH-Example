require "erb"
require 'fileutils'

module PreLoader

  # raise "No config found for environment: #{@@env}" unless @@env_config

  @@device = false
  @@server_loaded = true
  #@@constants = YAML.load(File.open('config/constants.yaml'))

  if ENV['PLATFORM'] == 'ios'
    require 'calabash-cucumber/cucumber'
    require 'calabash-cucumber/calabash_steps'
  elsif ENV['PLATFORM'] == 'android'
    require 'calabash-android/cucumber'
    require 'calabash-android/calabash_steps'
  end
    
  @@time = DateTime::now::strftime("%Y-%m-%d_%H:%M:%S")


  def env_language
    @@env_lang
  end

  def constants
    @@constants
  end

end