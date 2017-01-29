require_relative 'button'
require_relative 'hooks'

class SceneTutorial
	
	#Forget about this
	def keyPressed id
		if id == Gosu::KbEscape
			$scene_hook = $scene_menu
		end
	end
	
	def keyReleased id
	end
	
	def mouseReleased mb, x, y
	end
	
	def mousePressed mb, x, y
		if mb == Gosu::MsLeft
			if @exit.contains(x,y)
				$scene_hook = $scene_menu
			end
		end
	end
	
	def update dt
		#not necessary
	end
	
	def draw
		@tutorial.draw(0, 75, 1)
		#@sel.draw()
		#@play.draw()
		@exit.draw()
	end
	
	
	def initialize
		#@sel = Button.new(400, 100, "PLAY AS")
		#@play = Button.new(400, 225, "YEEDNAH")
		#@font = Gosu::Font.new(24)
		tutext = """TUTORIAL:
		WASD/ARROW KEYS = MOVE
		MOUSE LEFT BUTTON: PRIMARY SKILL
		MOUSE RIGHT BUTTON: SECONDARY SKILL
		
		Kill as many humans as you can, they don't want to share their blood!
		"""
		
		
		@tutorial = Gosu::Image.from_text(tutext, 24 )
		
		@exit = Button.new($window_hook.width/2, 500, "Back")
	end
	
	
end