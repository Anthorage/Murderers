require_relative 'button'
require_relative 'hooks'

class SceneSelect
	
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
			if @play.contains(x,y)
				#SceneMaster.play(:Play)
				$scene_hook = $scene_play
				$scene_play.becomeHero $YEEDNAH
			elsif @exit.contains(x,y)
				$scene_hook = $scene_play
				$scene_play.becomeHero $TRISTOF
				#SceneMaster.finish()
				#$window_hook.finish()
			end
		end
	end
	
	def update dt
		#not necessary
	end
	
	def draw
		#@sel.draw()
		@play.draw()
		@exit.draw()
	end
	
	
	def initialize
		#@sel = Button.new(400, 100, "PLAY AS")
		@play = Button.new($window_hook.width/2, 225, "YEEDNAH")
		@exit = Button.new($window_hook.width/2, 375, "TRISTOF")
	end
	
	
end