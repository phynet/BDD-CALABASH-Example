class AndroidSnapshooter

  @@step = 1

  def initialize(cucumber_runtime, image_path, failure_path)
    @cucumber_runtime = cucumber_runtime
    @image_path = image_path
    @failure_path = failure_path
  end

  def save_step_image label
    if(!@image_path.nil?)
      FileUtils.mkdir_p(@image_path) unless File.directory?(@image_path)
      @cucumber_runtime.screenshot_embed({prefix: Dir.pwd + "/#{@image_path}", name: "step.png", label: label})
      @@step += 1
    end
  end

  def save_alert_image
    if(!@image_path.nil?)
      FileUtils.mkdir_p(@image_path) unless File.directory?(@image_path)
      @cucumber_runtime.screenshot_embed({prefix: Dir.pwd + "/#{@image_path}", name: "step_#{@@step}_alert", label: "Alert found"})
    end
  end

  def save_fail_image
    if(!@failure_path.nil?)
      FileUtils.mkdir_p(@failure_path) unless File.directory?(@failure_path)
      @cucumber_runtime.screenshot_embed({prefix: Dir.pwd + "/#{@failure_path}", name: "failure.png", label: "Failure!!!"})
    end
  end

end