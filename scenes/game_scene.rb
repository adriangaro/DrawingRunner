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
    add_collision_callbacks
  end

  def add_collision_callbacks
    @space.add_collision_handler :player,
                                 :ground,
                                 PlayerGroundCollisionHandler.new(self)
  end

  def update
    @drawings.delete_if {|x| x.update; x.clear if x.timer > 600; x.timer > 600}
    @player.body.reset_forces
    @floor.warp Point[-@offset.x, 400]
    @player.update
    @space.step(1.0 / 60)
  end


  def keyboard_controls
    @window.close if Gosu::button_down? Gosu::KbEscape
    @current_drawing.add_point Point[@window.mouse_x, @window.mouse_y] if Gosu::button_down? Gosu::MsLeft
    if !Gosu::button_down?(Gosu::MsLeft) && @current_drawing.point != nil
      @current_drawing.add_point Point[@window.mouse_x, @window.mouse_y]
      @current_drawing.create_drawing @offset
      @drawings << @current_drawing
      @current_drawing = Drawing.new @space
    end
    @player.jump() if Gosu::button_down? Gosu::KbSpace
  end

  def draw
    @offset = Point[[@window.width / 4 - @player.body.p.x, 0].min, [2.5 * @window.height / 4 - @player.body.p.y].min]
    @player.draw(@offset)
    @floor.draw @offset
    @background.draw(0,0,0, @window.width*1.0/@background.width, @window.height*1.0/@background.height)
    @current_drawing.draw @offset
    @drawings.each do |dr|
      dr.draw(@offset)
    end
  end
end
