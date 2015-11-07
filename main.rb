require_relative "requires"

class GameWindow < Gosu::Window
  attr_accessor :scene
  def initialize
    super 640, 480, false
  end

  def update
    add_mouse_controls

  end

  def draw

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
