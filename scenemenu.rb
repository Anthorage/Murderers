require_relative 'button'
require_relative 'hooks'

class SceneMenu
	
	def keyPressed id
	end
	
	def keyReleased id
	end
	
	def mouseReleased mb, x, y
		
	end
	
	def mousePressed mb, x, y
		if mb == Gosu::MsLeft
			if @play.contains(x,y)
				#SceneMaster.play(:Play)
				$scene_hook = $scene_intro
			elsif @exit.contains(x,y)
				#SceneMaster.finish()
				$window_hook.finish()
			elsif @tuto.contains(x,y)
				$scene_hook = $scene_tutorial
			end
		end
	end
	
	def update dt
		#not necessary
	end
	
	def draw
		@play.draw()
		@exit.draw()
		@tuto.draw()
	end
	
	
	def initialize
		@play = Button.new($window_hook.width/2, 200, "Play")
		@tuto = Button.new($window_hook.width/2, 300, "Tutorial")
		@exit = Button.new($window_hook.width/2, 400, "Exit")
	end
	
end