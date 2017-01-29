require_relative 'unit'
require_relative 'skills'

class Hero < Unit
	attr_reader :skill1, :skill2
	
	@@hook = nil
	
	def self.clearHero
		@@hook = nil
	end
	
	def self.getMyHero
		return @@hook
	end
	
	def findNearestEnemy()
	end
	
	def updateCombat dt
	end
	
	def update dt
		super dt
		
		if @skill1 != nil
			@skill1.update dt
		end
		
		if @skill2 != nil
			@skill2.update dt
		end
	end
	
	def draw
		super
		#UnitType.GRAPHICS[@utype.id].draw(@x, @y, @z, GRAPHIC_ZOOM, GRAPHIC_ZOOM)
	end
	
	
	def initialize x, y, type, player
		super x, y, type, player
		
		@@hook = self
		$hero_hook = self
		
		@z = HERO_Z
	end
	
end