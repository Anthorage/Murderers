require_relative 'utype'

require_relative 'entity'
require_relative 'missile'

class Unit < Entity
	attr_reader :utype, :player, :helprect
	attr_accessor :health
	
	
	@@ANIM_TIME = 1.0/4.0
	@@list = []
	
	
	def setOrder ord
		@order = ord
	end
	
	def self.get x, y
		@@list.each do |u|
			if u.helprect.contains(x,y)
				return u
			end
		end
		
		return nil
	end
	
	
	def stop(forget=true)
		super
		
		@anim_time = 0.0
		@panim = 0
		
		
		if forget
			@target = nil
		end
	end
	
	def travel(x,y,forget=true)
		#self.stop(forget)

		super x, y
		
				
		if forget
			@target = nil
		end
		
	end
	
	
	def findNearestEnemy()
		#cmat = @@mathook
		min = nil
		mindis = 0
		
		if @order != ATTACK
			myran = @utype.arange**2

					@@list.each do |other|

					dis = (@x-other.x)**2+(@y-other.y)**2

					
						if dis <= VIEW_RANGESQ and @player != other.player
							
							
							if dis <= myran
								min=other
								break
							elsif min == nil or dis < mindis
								min=other
								mindis = dis
							end
						end
					
					end

			
			@target = min
			
			if @target != nil
				travel @target.x, @target.y, false
			end
			
		end
		
	end
	
	
	def self.findEnemies()
		@@list.each do |u|
			u.findNearestEnemy
		end
	end
	
	
	def updateCombat(dt)
		if @target != nil 
			aproxdist = (@x-@target.x)**2+(@y-@target.y)**2
			aproxran = @utype.arange**2
			
			
			
			if @target.health <= 0
				stop()
				findNearestEnemy()
			elsif @order == ATTACK

				@angle = Gosu::angle(@x, @y, @target.x, @target.y)

				@attacktime -= dt
			
				if aproxdist <= aproxran
					if @attacktime < 0
						@attacktime = @utype.aspeed
						
						if @utype.missile == nil
							damageTarget(@target)
						else
							@utype.missile.uses.new(@x, @y, @target.x, @target.y, @utype.missile, self)
						end
					end
				else
					#@order=STAY
					travel @target.x, @target.y, false
				end
				
			else
				if aproxdist > VIEW_RANGESQ
					stop(true)
				elsif aproxdist > aproxran
					travel @target.x, @target.y, false
				else
					stop false
					@order = ATTACK
					#puts @target
				end
			end
		end
		
	end
	
	
	def self.getPlayered x, y, p
		@@list.each do |u|
			if u.helprect.contains(x,y) and p == u.player
				return u
			end
		end
		
		return nil
	end
	
	def self.list
		return @@list
	end
	
	def die killer
		Effect.new(@x, @y, $EFFECT_BLOOD, 0.35)
		@@list.delete(self)
	end
	
	def damageTarget who, dmg=@utype.damage
		#puts dmg
		who.health -= dmg #@utype.damage
		
		if who.health <= 0
			who.die(self)
		else
			if who.order == STAY# and (who.x, who.y, @x, @y) > VIEW_RANGESQ
				disx = who.x-@x
				disy = who.y-@y
				
				if (disx**2+disy**2) > VIEW_RANGESQ
					who.travel @x, @y
				end
			end
		end
	end
	
	def heal amm
		@health = [@health+amm, @utype.health].min
	end
	
	def movePos x, y
		@helprect.move @x+x, @y+y
		
		if $level_hook.borders.fullyIntersects(@helprect)
			super x, y
		else
			@helprect.move @x, @y
		end
	end
	
	def draw
		UnitType.GRAPHICS[@utype.id+@panim].draw_rot(@x, @y, @z, @angle, 0.5, 0.5, GRAPHIC_ZOOM, GRAPHIC_ZOOM)
		#@helprect.draw(Gosu::Color::WHITE, @z-1, 1)
	end
	
	
	def setAnim wa
		if wa >= 4 or wa < 0
			wa = 0
		end
		
		@panim = wa
	end
	
	
	def cast what, tx, ty
		if what == PRIMARY and @skill1 != nil
			if @skill1.canCast?(self, tx, ty)
				@skill1.onCast(self, tx, ty)
			end
		elsif what == SECONDARY and @skill2 != nil
			if @skill2.canCast?(self, tx, ty)
				@skill2.onCast(self, tx, ty)
			end
		end
	end
	
	
	def update dt
		super dt
		
		#@@list.each do |other|
		#end
		
		#@anim = ( (Gosu::milliseconds() / 200).to_i) % 4
		
		if @order == MOVE
			@anim_time += dt
			#puts @anim_interval
			
			if @anim_time > @@ANIM_TIME
				@anim_time = 0.0
				#print "uu "
				#puts @anim
				@panim += 1
				#puts @anim
				
				if @panim >= 4
					@panim = 0
				end
			end
		end
		
		
		updateCombat dt
		
	end
	
	def initialize x, y, type, player
		super x, y, type.speed
		
		@anim_time = 0.00
		#@anim_interval = @@ANIM_TIME/4.00
		@panim = 0
		
		@player=player
		@utype = type
		
		@target=nil
		@attacktime = type.aspeed/2.0
		
		@z=UNIT_Z
		
		@health = type.health
		
		@helprect = RectangleShape.new(x, y, GRAPHIC_TOT, GRAPHIC_TOT)
		
		@skill1 = nil
		@skill2 = nil
		
		@@list.push(self)
	end
	
end