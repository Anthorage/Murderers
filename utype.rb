require 'gosu'

require_relative 'const'
require_relative 'skills'
require_relative 'missiletype'


class UnitType
	attr_reader :id, :health, :damage, :speed, :aspeed, :arange, :missile
	
	@@GRAPHICS = Gosu::Image.load_tiles("graphics/characters.png", GRAPHIC_SIZE, GRAPHIC_SIZE, :retro=>true)
	@@ANIMS = 4
	
	
	def self.GRAPHICS
		return @@GRAPHICS
	end
	
	def initialize id, h, d, spd, aspd, ran=MELEE_RANGE, mis=nil
		@id=id*@@ANIMS
		@health=h.to_f
		@damage=d
		@speed=spd
		@aspeed=aspd
		
		@arange = ran
		@missile = mis
	end
	
end

=begin
class HeroType < UnitType
	attr_reader :skill1, :skill2
	
	def initialize id, h, d, spd, aspd, sk1, sk2
		super id, h, d, spd, aspd
		
		@skill1=sk1
		@skill2=sk2
	end
	
end
=end

$YEEDNAH = UnitType.new( 0, 10, 4, 88, 1.00 )
#$YEEDNAH = HeroType.new( 0, 10, 4, 96, 1.00, $BITE, $BLOOD_DART )

$WORKER = UnitType.new( 1, 6, 2, 36, 1.10, MELEE_RANGE*1.35 )
$ARCHER = UnitType.new( 2, 5, 2, 30, 1.35, MELEE_RANGE*3.00, $ARROW )
$MAGE = UnitType.new( 3, 4, 3, 28, 1.5, MELEE_RANGE*2.2, $PURGEBALL )

$TRISTOF = UnitType.new( 4, 12, 4, 72, 1.00 )

$VAMPIRE = UnitType.new( 5, 5, 2, 48, 1.00, MELEE_RANGE)


