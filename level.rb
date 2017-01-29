require_relative 'hero'
require_relative 'effect'

class Level
	@@FIND_TIMER=0.35
	
	attr_reader :victory, :defeat, :borders
	
	
	def winGame
		@victory=true
	end
	
	def loseGame
		@defeat=true
	end
	
	def update dt
		@findenemytimer-=dt
		
		Unit.list.each do |u|
			u.update(dt)
		end
		
		Missile.list.each do |m|
			m.update(dt)
		end
		
		Effect.list.each do |e|
			e.update(dt)
		end
		
		if @findenemytimer <= 0
			@findenemytimer = @@FIND_TIMER
			
			Unit.findEnemies()
		end
	end
	
	def draw
		@drawtiles.draw(@borders.x, @borders.y,TILE_Z)
		
		
		Unit.list.each do |u|
			u.draw()
		end
		
		Missile.list.each do |m|
			m.draw()
		end
		
		Effect.list.each do |e|
			e.draw()
		end
	end
	
	
	def loadTiles name
		File.open(name.to_s<<".txt") do |fech|
			#mentext = nil
			dowhat=0
			y=0
			
			
			fech.each_line do |line|
				
				if line.include?("MapSize")
					dowhat=1
				elsif line.size <= 2
					#dowhat=dowhat #forget about this
					dowhat=dowhat
				elsif dowhat==1
					data = line.split(' ')
					
					@matrix = Array.new(data[1].to_i) { Array.new(data[0].to_i, -1) }
					dowhat+=1

				elsif line.include?("Layer")
					dowhat+=1
					y=0
				elsif dowhat == 3 # or dowhat == 3
					x=0
					data = line.split(' ')

					data.each do |t|
						ti = t.to_i
						
						if ti >= 0
							@matrix[y][x] = ti
						end
						
						x+=1
					end
					
					y+=1
				end
			end
			
			#puts @matrix
		end
		
		@borders.resize(@matrix[0].size*GRAPHIC_TOT, @matrix.size*GRAPHIC_TOT)
		@borders.move($window_hook.width/2, $window_hook.height/2)

		
		@drawtiles = Gosu::record(@matrix[0].size*GRAPHIC_TOT, @matrix.size*GRAPHIC_TOT) {
			#my =@mmatrix.size
			#mx = @mmatrix[0].size
			#puts @matrix
			
			@matrix.each_index do |y|#my.times do |y|
				@matrix[y].each_index do |x|#mx.times do |x|
					if @matrix[y][x] != -1
						#puts x.to_s << " " << y.to_s << " " << @matrix[y][x].to_s
						@imageTileset[(@matrix[y][x])].draw(x*GRAPHIC_TOT, y*GRAPHIC_TOT, TILE_Z, GRAPHIC_ZOOM, GRAPHIC_ZOOM)
						
						#if @matrix[y][x] == 0
							#can+=1
						#end
					
					end
				end
			end
		}
		
		#puts can
		
	end
	
	def initialize name, borders
		@imageTileset = Gosu::Image.load_tiles("graphics/tileset.png", GRAPHIC_SIZE, GRAPHIC_SIZE, :retro=>true)
		@matrix = nil
		@drawtiles = nil
		
		
		@victory=false
		@defeat=false
		
		@borders = borders
		
		@findenemytimer=@@FIND_TIMER
		
		self.loadTiles(name)
	end
	
	def clear
		Unit.list.clear()
		Hero.clearHero()
		Missile.list.clear()
		Effect.list.clear()
		
		$hero_hook = nil
		
		@victory=false
		@defeat=false
	end
	
	def onEnter
		clear
	end
	
	def onExit
		clear
	end
	
end