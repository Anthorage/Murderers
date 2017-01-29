require 'gosu'

require_relative 'const'

class Skill
	@@GRAPHICS = Gosu::Image.load_tiles("graphics/skills.png", GRAPHIC_SIZE, GRAPHIC_SIZE, :retro=>true)
	
	def draw x, y
		w=1
		
		@rec.moveTopLeft x, y
		
		@rec.draw(Gosu::Color::WHITE, @z, w)
		@@GRAPHICS[@id].draw(x+w, y+w, @z+1, GRAPHIC_ZOOM, GRAPHIC_ZOOM)
	end
	
	def update dt
		if @castTime > 0
			@castTime -= dt
		end
	end
	
	def checkCondition who, x, y
		return true
	end
	
	def canCast? who, x, y
		return (@castTime <= 0 and $level_hook.borders.contains(x,y) and checkCondition(who, x, y))
	end
	
	def onCast who, tx, ty
		@castTime = @totalTime
	end
	
	def setCastTime ti
		@totalTime = ti
	end
	
	def constTime
		return 0.00
	end
	
	def initialize name, id
		@name = name
		@z=SKILL_Z
		@id = id
		
		@rec = RectangleShape.new(0,0,GRAPHIC_TOT+2,GRAPHIC_TOT+2)
		@rec.moveTopLeft(0, 0)
		
		@castTime = 0.00
		@totalTime = self.constTime
	end
	
	
end