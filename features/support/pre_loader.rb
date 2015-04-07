require "erb"
require 'fileutils'

module PreLoader

  # if defined? @@env_config
  #   puts "loading environments.yaml..."
  #   environments = YAML.load(File.open('config/environments.yaml'))
  #   @@env_config = environments[@@env.to_s]
  # end

  # raise "No config found for environment: #{@@env}" unless @@env_config

  @@device = false
  @@server_loaded = true
  #@@constants = YAML.load(File.open('config/constants.yaml'))

  if ENV['PLATFORM'] == 'ios'
    @@platform = :ios
    require 'calabash-cucumber/cucumber'
    require 'calabash-cucumber/calabash_steps'

    ARGV.each do |a|
      if a.eql? "ios_device"
        @@device = true
      end
    end

  elsif ENV['PLATFORM'] == 'android'
    @@platform = :android

    #ya que la gema de calabash-android está presentando muchos problemas en su version > 0.4.20
    #he creado este método que verifica la versión de dicha gema para emplear en los helpers
    #los métodos correspondientes a esta versión "antigua" y dejar un condicional con los
    # métodos de las versiones posteriores
    @@calabash_android_v = File.open('Gemfile')
    @@env_calabash_version = nil

    @@calabash_android_v.each_line do |line|
      line_data = line.split(',')
      name_data = line_data[0]
      version_data = line_data[1]
      if name_data.eql? "gem 'calabash-android'"
        puts "version #{name_data} #{version_data} "
        @@env_calabash_version = version_data.chop.tr("'",'').strip
      end
    end
    @@calabash_android_v.close

    require 'calabash-android/cucumber'
    require 'calabash-android/calabash_steps'
  end
    
  @@time = DateTime::now::strftime("%Y-%m-%d_%H:%M:%S")


  def env_config
    @@env_config
  end

  def env_language
    @@env_lang
  end

  def constants
    @@constants
  end

  def android_calabash_version
    @@env_calabash_version
  end

  def device
    @@device
  end

  def server_loaded
    aux = @@server_loaded
    @@server_loaded = false
    aux
  end

  def test_start_time
    @@time
  end

 

end