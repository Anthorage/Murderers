
require_relative 'missile'
require_relative 'effect'

class EnergyMissile < Missile
	
	def destroy
		super
		
		#if @collok
			#BiteMissile.new(@x, @y, @owner.x, @owner.y, $BITE, @owner, {:target=>@owner, :collide=>false})
		#end
		
		Effect.new(@x, @y, $EFFECT_PURGE, 0.5)
	end
	
end