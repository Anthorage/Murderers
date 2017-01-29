
class Entity
	attr_reader :order, :x, :y
	#attr_accessor :_speed
	
	def getSpeed
		return @_speed
	end
	
	def setSpeed spd
		@_speed = spd
	end
	
	def updateMovement dt
		if @order == MOVE
			if @tardist >= @_speed*dt
				spd = @_speed*dt#@utype.speed*dt
				movePos @tancos*spd, @tansin*spd
				
				@tardist-=spd
			else
				@order = STAY
			end
		end
	end
	
	def stop sorryneedtorecheckunitstopsuper=nil
		@tardist=0
		@order=STAY
	end
	
	def update dt
		updateMovement dt
	end
	
	def setPos x, y
		@x=x
		@y=y
	end
	
	def movePos x, y
		@x+=x
		@y+=y
	end
	
	def lookAt x, y
		@angle = Gosu::angle(@x, @y, x, y)
	end
	
	def travel x, y
		if $level_hook.borders.contains(x, y)
			tang = Gosu::angle(@x, @y, x, y)
			
			@angle = tang
			#tang = (tang.degrees_to_radians).radians_to_gosu
			
			#puts( (Math::PI).radians_to_gosu)
			
			if @tang > 45 and @tang < 135
				@anim = 1
			elsif @tang > 135 and @tang < 225
				@anim = 0
			elsif @tang > 225 and @tang < 315
				@anim = 3
			else
				@anim = 2
			end
			
			tang = tang.gosu_to_radians #(tang- 90) * (Math::PI / 180.0)
			
			@tancos = Math::cos(tang)
			@tansin = Math::sin(tang)
			
			@tardist = Gosu::distance(@x, @y, x, y)
			
			@order = MOVE
		else
			@tardist=0
			@order = STAY
		end
	end
	
	def initialize x, y, speed
		@x =x
		@y=y
		
		@order = STAY
		
		@angle=0
		
		@_speed = speed
		
		@tang=0
		@tancos=0
		@tansin=0
		@tardist=0
	end
	
end