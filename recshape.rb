require 'gosu'

class RectangleShape
	attr_reader :x, :y, :w, :h
	
	def move x, y
		@x = x-@w/2
		@y = y-@h/2
	end
	
	def moveTopLeft x, y
		@x=x
		@y=y
	end
	
	def resize w, h
		@w = w
		@h = h
	end
	
	def center
		return [@x+@w/2, @y+@h/2]
	end
	
	
	def fullyIntersects(b)
		return ( contains(b.x, b.y) and contains(b.x+b.w, b.y)  and contains(b.x+b.w,b.y+b.h) and contains(b.x, b.y+b.h) )
	end
	
	#def getPartitionCoords
		
	#end
	
	
	def intersects(b) 
		apos = [ @x , @y , @x + @w, @y+@h ]
		
		bpos = [ b.x, b.y , b.x + b.w, b.y+b.h ]
		
		return (apos[0] <= bpos[2] and bpos[0] <= apos[2] and apos[1] <= bpos[3] and bpos[1] <= apos[3])
	end

	
	def draw col, z, cant=1
		c = col #Gosu::Color::WHITE
		
		cant.times do |con|
			x = @x+con
			y = @y+con
			w = @w-con*2
			h = @h-con*2
			
			Gosu::draw_line(x, y, c, x+w, y, c, z)
			Gosu::draw_line(x+w, y, c, x+w, y+h, c, z)
			Gosu::draw_line(x+w, y+h, c, x, y+h, c, z)
			Gosu::draw_line(x, y+h, c, x, y, c, z)
		end
		
	end
	
	def contains(xp, yp)
		return (xp > @x and yp > @y and xp < @x+@w and yp < @y+@h)
	end
	
	def randPoint()
		return [ @x+UNIT_GTOTX+rand(  [0, @w-UNIT_GTOTX*2].max ), @y+UNIT_GTOTY+rand( [0, @h-UNIT_GTOTY*2].max) ]
	end
	
	
	def initialize(x, y, w, h, centered=true)
		if centered
			@x=x-w/2
			@y=y-h/2
		else
			@x=x
			@y=y
		end
		@w=w
		@h=h
	end
	
end