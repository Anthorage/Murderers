require 'gosu'

require_relative 'hooks'
require_relative 'level1'

class ScenePlay
	@@damagedColor = Gosu::Color.new(255, 128, 0, 0)
	
	
	def becomeHero wha
		#$hero_hook.kill
		Unit.list.delete($hero_hook)
		
		if wha == $TRISTOF
			$hero_hook = Tristof.new($hero_hook.x, $hero_hook.y, wha, GOOD_PLAYER)
		elsif wha == $YEEDNAH
			$hero_hook = Yeednah.new($hero_hook.x, $hero_hook.y, wha, GOOD_PLAYER)
		end
	end
	
	def mouseReleased mb, x, y
	end
	
	def mousePressed mb, x, y
		if mb == Gosu::MsLeft
			Hero.getMyHero().cast(PRIMARY, x, y)
		elsif mb == Gosu::MsRight
			Hero.getMyHero().cast(SECONDARY, x, y)
		end
	end
	
	def moreLevels?(num)
		return ( (num+1) < @levels.size )
	end
	
	def keyPressed id
		#if id == Gosu::KbEscape
			#$scene_hook = $scene_select
		#end
	end
	
	def keyReleased id
	end
	
	def gameLogic(dt)
		mpx = $window_hook.mouse_x
		mpy = $window_hook.mouse_y
		
		he = Hero.getMyHero()
		
		#he.setOrder STAY
		
		mx=0
		my=0
		
		if Gosu::button_down?(Gosu::KbLeft) or Gosu::button_down?(Gosu::KbA)
			mx=-4
		elsif Gosu::button_down?(Gosu::KbRight) or Gosu::button_down?(Gosu::KbD)
			mx=4
		end
		
		if Gosu::button_down?(Gosu::KbUp) or Gosu::button_down?(Gosu::KbW)
			my=-4
		elsif Gosu::button_down?(Gosu::KbDown) or Gosu::button_down?(Gosu::KbS)
			my=4
		end
		
		if mx != 0 or my != 0
			he.travel he.x+mx, he.y+my
		end
		
		if he.order == STAY
			he.setAnim 0
		end
		
=begin		
		if Gosu::button_down?(Gosu::KbLeft) or Gosu::button_down?(Gosu::KbA)
			#he.movePos(-he.utype.speed*dt, 0)
			he.travel(he.x-4, he.y)
			#he.setOrder MOVE
		elsif Gosu::button_down?(Gosu::KbRight) or Gosu::button_down?(Gosu::KbD)
			#he.movePos(he.utype.speed*dt, 0)
			he.travel(he.x+4, he.y)
			#he.setOrder MOVE
		end
		
		if Gosu::button_down?(Gosu::KbUp) or Gosu::button_down?(Gosu::KbW)
			#he.movePos(0, -he.utype.speed*dt)
			he.travel(he.x, he.y-4)
			#he.setOrder MOVE
		elsif Gosu::button_down?(Gosu::KbDown) or Gosu::button_down?(Gosu::KbS)
			#he.movePos(0, he.utype.speed*dt)
			he.travel(he.x, he.y+4)
			#he.setOrder MOVE
		end
=end
		
		he.lookAt(mpx, mpy)
	end
	
	def update dt
		#@game_area.resize $window_hook.width-2, $window_hook.height-4-GRAPHIC_TOT
		
		@playing_time += dt
		
		
		
		if @acmap != nil
			
			@acmap.update dt
			
			if @acmap.victory
				@playing_time = 0.00
				if self.moreLevels?(@level_id)
					setLevel(@level_id+1)
				else
					$window_hook.finish()
				end
			elsif @acmap.defeat
				@playing_time = 0.00
				setLevel(@level_id)
				$scene_hook = $scene_select
			else
				self.gameLogic(dt)
			end
			
		end
	end
	
	
	def drawHeroSkills
		he = Hero.getMyHero()
		
		he.skill1.draw(1,$window_hook.height-GRAPHIC_TOT-2)
		he.skill2.draw($window_hook.width-GRAPHIC_TOT-3,$window_hook.height-GRAPHIC_TOT-2)
		

		
		th = (he.health/he.utype.health).to_f
		
		ww = $window_hook.width
		wh = $window_hook.height
		
		Gosu::draw_rect(ww/2 - GRAPHIC_TOT*2, wh-GRAPHIC_TOT-2, (GRAPHIC_TOT*4), GRAPHIC_TOT, @@damagedColor, SKILL_Z)
		Gosu::draw_rect(ww/2 - GRAPHIC_TOT*2, wh-GRAPHIC_TOT-2, (GRAPHIC_TOT*4) * th, GRAPHIC_TOT, Gosu::Color::RED, SKILL_Z)
		
		#@lifebar[th].draw(ww/2 - GRAPHIC_TOT*2, $window_hook.height-GRAPHIC_TOT-2, SKILL_Z, GRAPHIC_ZOOM*4, GRAPHIC_ZOOM)
	end
	
	def draw
		if @acmap != nil
			@acmap.draw()
			#@game_area.draw(Gosu::Color::YELLOW, 0, 1)
			
			self.drawHeroSkills()
			
			timsec = @playing_time.to_i
			
			min = (timsec/60).to_i
			sec = (timsec%60)
			eapp = ":"
			
			if sec < 10
				eapp << "0"
			end
			
			@font.draw(min.to_s << eapp << sec.to_s, $window_hook.width/2, 32, SKILL_Z)
		end
	end
	
	def setLevel(id)
		if @acmap != nil
			@acmap.onExit()
		end
		
		@level_id = id
		@acmap = @levels[@level_id]
		
		$level_hook = @acmap
		
		if @acmap != nil
			@acmap.onEnter()
		end
	end
	
	def initialize
		@game_area = RectangleShape.new($window_hook.width/2,$window_hook.height/2, 400,300)
		#@game_area.resize $window_hook.width-2, $window_hook.height-4-GRAPHIC_TOT
		
		@levels = [Level1.new(@game_area)]
		@level_id = 0
		
		@font = Gosu::Font.new(24)
		@playing_time = 0.00
		
		#@lifebar = Gosu::Image.load_tiles("graphics/life.png", GRAPHIC_SIZE, GRAPHIC_SIZE, :retro=>true)
		#@lifebar = RectangleShape.new
		
		setLevel(0)
	end
	
end