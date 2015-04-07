# Requiring this file will import Calabash and the Calabash predefined Steps.
require 'calabash-cucumber/cucumber'
require 'rspec/expectations'
require 'byebug'
require 'date'
require File.expand_path('../pre_loader', __FILE__)
include PreLoader
require_relative  '../../features/helpers/media_mobile'
require_relative '../screens/common_screen'

# Enable using plain MiniTest assertions instead of quasi-english shoulda
require 'test/unit/assertions'
World Test::Unit::Assertions