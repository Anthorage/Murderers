require 'gosu'
require_relative 'const'
require_relative 'missile'
require_relative 'energy_missile'


class MissileType
	attr_reader :id, :speed
	
	@@GRAPHICS = Gosu::Image.load_tiles("graphics/missiles.png", GRAPHIC_SIZE, GRAPHIC_SIZE, :retro=>true)

	def self.GRAPHICS
		return @@GRAPHICS
	end
	
	def uses
		return @_createwith
	end

	def initialize gid, spd, cw=Missile
		@id=gid
		@speed=spd
		
		@_createwith = cw
	end

end

$DART = MissileType.new(0, 192)
$BITE = MissileType.new(1, 192)
$ARROW = MissileType.new(2, 192)
$PURGEBALL = MissileType.new(3, 160, EnergyMissile)