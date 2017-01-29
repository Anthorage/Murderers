require_relative 'effecttype'

class Effect
	@@CANT_ANIM=3
	@@list = []
	
	def self.list
		return @@list
	end
	
	def draw
		@type.anim[@panim].draw_rot(@x, @y, @z, 0, 0.5, 0.5, GRAPHIC_ZOOM_REDUCED + @extrazoom, GRAPHIC_ZOOM_REDUCED + @extrazoom)
	end
	
	def update dt
		if @attach != nil
			@x=@attach.x
			@y=@attach.y
		end
		
		@duration += dt
		
		if @duration > @interval
			@panim+=1
			@duration = 0.0
			
			if @panim >= @@CANT_ANIM
				@@list.delete self
			end
			#@@list.delete self
		end
	end
	
	def zoomup ez
		@extrazoom = ez
	end
	
	def initialize x, y, type, duration, attach=nil
		@attach = attach
		
		@x =x
		@y=y
		
		@type = type
		
		@extrazoom=1
		
		@duration = 0
		@interval = duration/@@CANT_ANIM
		@panim=0
		
		@z=BUFF_Z
		
		if attach != nil
			@z+=1
		end
		
		@@list.push self
	end
	
end