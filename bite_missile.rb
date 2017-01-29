
require_relative 'missile'


class BiteMissile < Missile
	
	def destroy
		super
		
		if @collok
			BiteMissile.new(@x, @y, @owner.x, @owner.y, $BITE, @owner, {:target=>@owner, :collide=>false})
		end
	end
	
end