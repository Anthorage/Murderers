require_relative 'skills'
require_relative 'missile'


class BloodDart < Skill
	
	
	def checkCondition who, x, y
		return who.health > who.utype.health/10
	end
	
	def onCast who, x, y
		super
		Missile.new(who.x, who.y, x, y, $DART, who, {:maxdist=>200} )
		
		who.heal (-who.utype.health/10)
	end
	
	def constTime
		return 0.25
	end
	
	def initialize
		super "Dart", 1
		
		#@totalTime = self.constTime
	end
	
end