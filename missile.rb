require 'gosu'

require_relative 'entity'
require_relative 'unit'

require_relative 'missiletype'

class Missile < Entity
	@@list = []
	
	
	def self.list
		return @@list
	end
	
	def draw
		MissileType.GRAPHICS[@utype.id].draw_rot(@x, @y, @z, @angle, 0.5, 0.5, GRAPHIC_ZOOM_REDUCED, GRAPHIC_ZOOM_REDUCED)
	end
	
	
	def destroy
		@@list.delete(self)
	end
	
	def update dt
		super dt
		
		if @homtar != nil and @tardist > 4
			travel @homtar.x, @homtar.y
		end
		
		if @order == MOVE and $level_hook.borders.contains(@x, @y)
			if @collok
				Unit.list.each do |un|
					if un.player != @owner.player and un.helprect.contains(@x, @y)
						@owner.damageTarget(un)
						self.destroy()
						break
					end
				end
			end
		else
			self.destroy()
		end
		
	end
	
	def initialize x, y, x2, y2, type, owner, options={} # options are: target, collide, maxdist
		super x, y, type.speed
		
		@homtar = options.fetch(:target, nil)
		@collok = options.fetch(:collide, true)
		maxdist = options.fetch(:maxdist, 1000)
		
		if @homtar != nil
			x2 = @homtar.x
			y2 = @homtar.y
		end
		
		travel x2, y2
		
		# under tests
		@tardist = [maxdist, @tardist+4].min
		#
		
		#@collok = !avoidCollision
		
		@owner = owner
		
		@utype = type
		
		@z = MISSILE_Z
		
		@@list.push(self)
	end
	
end