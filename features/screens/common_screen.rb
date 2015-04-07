class CommonScreen < MediaMobile
	attr_reader :screen_id, :selector
 
def initialize(screen_id,selector_id=nil)
   p 'initialize'
   super()
   @selector = selector_id
   @screen_id = screen_id
   p @selector
   p @screen_id
end

 def wait_for_screen(timeout=20)
 	puts "Waiting for screen of type #{self.class}"
 	p @selector
 	wait(@screen_id)
 end

end