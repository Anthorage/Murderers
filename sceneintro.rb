require_relative 'button'
require_relative 'hooks'

class SceneIntro
	
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
				$scene_hook = $scene_select
			end
		end
	end
	
	def update dt
		#not necessary
	end
	
	def draw
		tx = @introim.width*4
		ty = @introim.height*3
		
		@tutorial.draw(0, ty+50, 1)
		#@sel.draw()
		#@play.draw()
		@exit.draw()
		
		@introim.draw( ($window_hook.width - tx)/2, 50, 2, 4, 3)
	end
	
	
	def initialize
		#@sel = Button.new(400, 100, "PLAY AS")
		#@play = Button.new(400, 225, "YEEDNAH")
		#@font = Gosu::Font.new(24)
		tutext = """
		My sweet Yeednah. This, will be our last night together.
		
		The town army have finally found our track and are on their way here. It's too late to escape.
		
		One hundred years together. Vampires, they called us. Ain't it funny? They place a curse on us
		and then they hunt us down. I won't die with my hands clean, of that im completely sure.
		
		We feasted with their blood, and with their blood in our teeth, we shall die.
		
		Let's drink now, the blood, is still hot. Our last time together has to be, unforgettable.
		"""
		
		@introim = Gosu::Image.new("graphics/intro.png", {:retro=>true})
		
		
		@tutorial = Gosu::Image.from_text(tutext, 22)
		
		@exit = Button.new($window_hook.width/2, $window_hook.height-48, "Start")
	end
	
	
end