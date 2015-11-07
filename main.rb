require_relative "requires"

class GameWindow < Gosu::Window
  attr_accessor :scene
  def initialize
    super 640, 480, true
    @background = Gosu::Image.new("resources/images/main_menu_bg.jpg", options={})
    @button = Button.new(self.width / 2,self.height / 3,125,40,"resources/images/button_start_default.png")
    @button.on_hover_block = lambda { @image = Gosu::Image.new("resources/images/button_start_hover.png") }


  end

  def update
    add_keyboard_controls
    add_mouse_controls
    add_hover_ability
  end

  def add_keyboard_controls
    close if button_down? Gosu::KbEscape
  end

  def needs_cursor?
    true
  end

  def draw
    @background.draw(0,0,0, self.width*1.0/@background.width, self.height*1.0/@background.height)
    @button.draw
  end

  def add_hover_ability
    @scene.on_hover_exit
    @scene.on_hover
  end

  def add_mouse_controls
    @scene.onclick if button_down? Gosu::MsLeft
  end
end

$window = GameWindow.new
$window.show
