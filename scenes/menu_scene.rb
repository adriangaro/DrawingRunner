class MenuScene < Scene
  def initialize(window)
    super window
    @background = Gosu::Image.new("resources/images/main_menu_bg.jpg")
    @button = Button.new(@window.width / 2,@window.height / 3,125,40,"resources/images/button_start_default.png")
    @button.on_hover_block = lambda { @button.image = Gosu::Image.new("resources/images/button_start_hover.png") }
    @buttons << @button
  end

  def draw
    @background.draw(0,0,0, @window.width*1.0/@background.width, @window.height*1.0/@background.height)
    @buttons.each do |but|
      but.draw
    end
  end
end
