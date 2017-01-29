require 'gosu'

require_relative 'const'
require_relative 'hooks'
require_relative 'scenemenu'
require_relative 'sceneplay'
require_relative 'sceneselect'
require_relative 'scenetutorial'
require_relative 'sceneintro'

class GameWindow < Gosu::Window
	
	def finish
		self.close()
	end
	
	def update
		dt=0
		fps = Gosu::fps()
		
		if fps > 0
			dt = 1.0/Gosu::fps
		end
		
		
		if dt < (TIME_FPS_CONST)
			#update thing
			
			if $scene_hook != nil
				$scene_hook.update(dt)
			end
		end
	end
	
	
	def button_down id
		if id == Gosu::MsLeft or id == Gosu::MsRight or id == Gosu::MsMiddle
			$scene_hook.mousePressed(id, self.mouse_x, self.mouse_y)
		else
			$scene_hook.keyPressed(id)
		end
	end
	
	def button_up id
		if id == Gosu::MsLeft or id == Gosu::MsRight or id == Gosu::MsMiddle
			$scene_hook.mouseReleased(id, self.mouse_x, self.mouse_y)
		else
			$scene_hook.keyReleased(id)
		end
	end
	
	
	
	def draw
		@moucur.draw self.mouse_x-GRAPHIC_ZOOM, self.mouse_y, 10, GRAPHIC_ZOOM, GRAPHIC_ZOOM
		
		if $scene_hook != nil
			$scene_hook.draw()
		end
	end
	
	def initialize
		super 800, 600, false
		
		self.caption = "Murderers"
		
		$window_hook = self
		
		$scene_menu = SceneMenu.new()
		$scene_play = ScenePlay.new()
		$scene_select = SceneSelect.new()
		$scene_tutorial = SceneTutorial.new()
		$scene_intro = SceneIntro.new()
		
		$scene_hook = $scene_menu
		
		@moucur = Gosu::Image.new("graphics/cursor.png", :retro=>true)
	end
	
	#def needs_cursor?
		#true
	#end
	
end

$window_hook = nil
gwn = GameWindow.new()
gwn.show()
