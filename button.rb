require_relative 'recshape'

class Button
	
	def draw
		@bor.draw Gosu::Color::YELLOW, 1
		@img.draw @bor.x+2, @bor.y+2, 1
	end
	
	def contains x, y
		return @bor.contains(x,y)
	end
	
	def initialize x, y, text
		@img = Gosu::Image.from_text(text, 32)
		@bor = RectangleShape.new(x, y, @img.width+4, @img.height+4)
	end
	
end