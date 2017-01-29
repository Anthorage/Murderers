require_relative 'hero'
require_relative 'dart'
require_relative 'bite'
require_relative 'whirlwind'

class Yeednah < Hero
	
	
	#def updateMovement dt
	#end
	
	def initialize x, y, type, player
		super x, y, type, player
		
		@skill1 = Bite.new()
		@skill2 = BloodDart.new()
	end
	
end