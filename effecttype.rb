require 'gosu'
require_relative 'const'


class EffectType
	@@CANT_ANIM=3
	
	attr_reader :id, :anim
	
	@@GRAPHICS = Gosu::Image.load_tiles("graphics/effects.png", GRAPHIC_SIZE, GRAPHIC_SIZE, :retro=>true)

	def initialize gid
		@id=gid*@@CANT_ANIM
		
		@anim = @@GRAPHICS[@id..@id+2]
	end

end


$EFFECT_BITE = EffectType.new(0)
$EFFECT_PURGE = EffectType.new(1)
$EFFECT_BLOOD = EffectType.new(2)