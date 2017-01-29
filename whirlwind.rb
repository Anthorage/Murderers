require_relative 'skills'
#require_relative 'bite_missile'
require_relative 'effect'


class Teleport < Skill
	
	def checkCondition who, x, y
		return (who.health > (who.utype.health/4))
	end
	
	def onCast who, x, y
		super
		Effect.new(who.x, who.y, $EFFECT_BLOOD, 0.7)
		
		Unit.new(who.x, who.y, $VAMPIRE, GOOD_PLAYER)
		
		who.setPos x, y
		
		who.heal(-who.utype.health/4)
	end
	
	def constTime
		return 3.00
	end
	
	def initialize
		super "Whirlwind", 2
		
		#@totalTime = self.constTime
	end
	
end