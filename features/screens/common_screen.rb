class CommonScreen < MediaMobile
	attr_reader :screen_id
 
def initialize(screen_id)
	super()
  @screen_id = screen_id
end

 def wait_for_screen(timeout=40)
 	puts "Waiting for screen of type #{self.class}"
  check_element(screen_id,timeout)
 end

end