require_relative 'skills'
#require_relative 'bite_missile'
require_relative 'effect'


class Bite < Skill
	
	
	def checkCondition who, x, y
		en = Unit.getPlayered(x, y, BAD_PLAYER)
		return (en != nil and Gosu::distance(who.x, who.y, en.x, en.y) <= 40)
	end
	
	def onCast who, x, y
		super
		#BiteMissile.new(who.x, who.y, x, y, $BITE, who, {:maxdist=>60} )
		en = Unit.getPlayered(x, y, BAD_PLAYER)
		Effect.new(en.x, en.y, $EFFECT_BITE, 0.5 ,en)
		
		who.damageTarget(en, en.utype.damage+5)
		who.heal(who.utype.health/5)
	end
	
	def constFixed
		return 0.95
	end
	
	def constTime
		return @totalTime
	end
	
	def initialize tot=self.constFixed()
		super "Bite", 0
		
		@totalTime = tot
	end
	
end