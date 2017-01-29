require_relative 'level'
require_relative 'yeednah'
require_relative 'tristof'

class Level1 < Level
	
	
	def timertime
		return 1.4
	end
	
	
	def summonUnit who, cant=1
		if Unit.list.size < 25
			cant.times do |n|
				cho = @areas[Gosu::random(0, 4)].center
				
				ang = Gosu::angle(cho.first, cho.last, @borders.center.first, @borders.center.last).gosu_to_radians
				siny = Math::sin(ang) * n * 8
				cosx = Math::cos(ang) * n * 8
				
				Unit.new(cho.first+cosx, cho.last+siny, who, BAD_PLAYER).travel Hero.getMyHero.x, Hero.getMyHero.y
			end
		end
	end
	
	def update dt
		super
		
		if Hero.getMyHero.health <= 0
			loseGame()
		end
		
		@timer -= dt
		
		if @timer <= 0
			@timer=self.timertime()
			
			#if @timerticks == 15
				#@summonwhat = $ARCHER
			#elsif @timerticks == 30
				#@summonwhat = $MAGE
			#end
			
			#cant = 1
			
			tt = @timerticks%6
			
			if tt == 0
				summonUnit($WORKER)
			elsif tt == 1
				summonUnit($WORKER, 2)
				cant=2
			elsif tt == 2
				summonUnit($ARCHER, 1)
			elsif tt == 3
				summonUnit($MAGE, 1)
			elsif tt == 4
				summonUnit($WORKER, 1)
			elsif tt == 5
				summonUnit($ARCHER, 1)
				summonUnit($MAGE, 1)
			end
			
			#if @timerticks%10 == 0
				#@summonwhat = $MAGE
				#cant = 2
			#end
			
			@timerticks+=1

			
			Unit.list.each do |u|
				if u.order == STAY
					u.travel Hero.getMyHero.x, Hero.getMyHero.y, false
				#u.setSpeed u.getSpeed+dt
				end
			end
		
		end
		
		#Unit.list.each do |u|
			#u.travel @per.x, @per.y, false
			#u.setSpeed u.getSpeed+dt
		#end
		
	end
	
	def onEnter
		super
		
		per = Tristof.new(@borders.center.first, @borders.center.last, $TRISTOF, GOOD_PLAYER)
		
		r1 = RectangleShape.new(@borders.x, @borders.y, @borders.w, GRAPHIC_TOT, false)
		r2 = RectangleShape.new(@borders.x+@borders.w-GRAPHIC_TOT, @borders.y, GRAPHIC_TOT, @borders.h, false)
		r3 = RectangleShape.new(@borders.x, @borders.y+@borders.h-GRAPHIC_TOT, @borders.w, GRAPHIC_TOT, false)
		r4 = RectangleShape.new(@borders.x, @borders.y, GRAPHIC_TOT, @borders.h, false)
		
		@areas = [ r1, r2, r3, r4 ]
		
		@timer = 1.0
		@timerticks = 0
		
		#@summonwhat = $WORKER
		
		#Unit.new(200, 300, $WORKER, BAD_PLAYER)
		#6.times { Unit.new( @borders.x + Gosu::random(0, @borders.w), @borders.y + Gosu::random(0, @borders.h), $MAGE, BAD_PLAYER) }
	end
	
	def initialize bor
		super "map1", bor
	end
	
end