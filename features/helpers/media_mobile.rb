class MediaMobile
  
  def initialize
    if ENV['PLATFORM'].include? 'ios' || ENV['PLATFORM'].nil?
      lib = "Ios"
      require_relative 'ios/ios_helper'
      require_relative 'ios/support/ios-snapshot'
    elsif ENV['PLATFORM'].include? 'android'
      lib = "Android"
      require_relative 'android/android_helper'
      require_relative 'android/support/android-snapshot'
    end
    eval("extend #{lib}Helper")
  end

  def method_missing(method, *args)
    if method.to_s.include? 'is_'
      method_class = method.to_s.split('_')[1].tr('?','')
      method_class.eql? self.who_i_am.to_s
    end
  end

  def is_native?
    return is_ios? || is_android?
  end

  def is_ios?
    return who_i_am == :ios
  end

  def is_android?
    return who_i_am ==  :android
  end
end