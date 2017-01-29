require_relative 'hero'
require_relative 'dart'
require_relative 'bite'
require_relative 'whirlwind'

class Tristof < Hero
	
	
	#def updateMovement dt
	#end
	
	def initialize x, y, type, player
		super x, y, type, player
		
		@skill1 = Bite.new(0.8)
		@skill2 = Teleport.new() #BloodDart.new()
	end
	
end