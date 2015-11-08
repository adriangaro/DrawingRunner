class GameScene < Scene
  attr_accessor :player
  def initialize(window)
    super window
    @floor = Floor.new @space
    @background = Gosu::Image.new("resources/images/interface/main_menu_bg.jpg")
    @player = Player.new @space
    @player.warp Point[100, 320]
    @drawings = []
    @current_drawing = Drawing.new @space
    @eraser = Eraser.new @space, @window.height
    add_collision_callbacks
    @d = 0
    @max_ink = 500
    @cur_ink = @max_ink
    @ink = Gosu::Image.new("resources/images/interface/ink_text.png")
    @ink_empty = Gosu::Image.new("resources/images/interface/ink_empty.png")
    @ink_full = Gosu::Image.new("resources/images/interface/ink_full.png")
    @last_ink = @cur_ink
  end

  def add_collision_callbacks
    @space.add_collision_handler :player,
                                 :ground,
                                 PlayerGroundCollisionHandler.new(self)
  end

  def update
    if(@cur_ink >= @last_ink && @current_drawing.point == nil )
      @cur_ink += 4
    end
    if(@cur_ink > @max_ink)
      @cur_ink = @max_ink
    end
    @d += 1
    @current_drawing.update
    @drawings.delete_if {|x| x.update; x.clear if x.timer > 600; x.timer > 600}
    @eraser.update
    @player.body.reset_forces
    @floor.warp Point[-@offset.x, 400]
    @player.update(@d)
    @space.step(1.0 / 60)
  end


  def keyboard_controls
    @window.close if Gosu::button_down? Gosu::KbEscape
    @last_ink = @cur_ink if(!Gosu::button_down?(Gosu::MsLeft))
    if(@cur_ink > 0 && Gosu::button_down?(Gosu::MsLeft))
      @cur_ink -= (@current_drawing.point.to_vec2 - Point[@window.mouse_x, @window.mouse_y].to_vec2).length if @current_drawing.point != nil
      @current_drawing.add_point Point[@window.mouse_x, @window.mouse_y]
    elsif (!Gosu::button_down?(Gosu::MsLeft) && @current_drawing.point != nil) || @cur_ink < 0
      @current_drawing.add_point Point[@window.mouse_x, @window.mouse_y]
      @current_drawing.create_drawing @offset
      @drawings << @current_drawing                    #you're gonna be fired :P
      @current_drawing = Drawing.new @space            #like really b
    end                                                #don't even think of escaping...
    @player.jump() if Gosu::button_down? Gosu::KbSpace #i'm gonna compose here..
  end                                                  #coooomeeennttaqaaarriuuuuuu

  def draw
    @offset = Point[[1.5 * @window.width / 4 - @player.body.p.x, @offset.x - 1 * 1.05 ** (@d / 300)].min, [2.5 * @window.height / 4 - @player.body.p.y].min]
    @player.draw(@offset)
    @eraser.draw(@offset)
    @floor.draw @offset
    @background.draw(0,0,0, @window.width*1.0/@background.width, @window.height*1.0/@background.height)
    @current_drawing.draw @offset
    @drawings.each do |dr|
      dr.draw(@offset)
    end
    @ink.draw(2.5 * @window.width / 4, 10, 4, @window.width / 12.0 / @ink.width, @window.height / 12.0 / @ink.height)
    @ink_empty.draw(2.5 * @window.width / 4 + 1.5 * @window.width / 12.0, 10, 4, (@window.width - 2.5 * @window.width / 4 - @window.width / 6.0) / @ink_empty.width, @window.height / 12.0 / @ink.height)
    @ink_full.draw(2.5 * @window.width / 4 + 1.5 * @window.width / 12.0, 10, 4, (@window.width - 2.5 * @window.width / 4 - @window.width / 6.0) / @ink_empty.width * @cur_ink / @max_ink > 0 ? (@window.width - 2.5 * @window.width / 4 - @window.width / 6.0) / @ink_empty.width * @cur_ink / @max_ink : 0, @window.height / 12.0 / @ink.height)
  end
end
