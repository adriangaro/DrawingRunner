require_relative "requires"

class GameWindow < Gosu::Window
  attr_accessor :scene
  def initialize
    super 640, 480, true
    @scene = MenuScene.new self
  end

  def update
    add_keyboard_controls
    add_mouse_controls
    add_hover_ability
    @scene.update
  end

  def add_keyboard_controls
    close if button_down? Gosu::KbEscape
  end

  def needs_cursor?
    true
  end

  def draw
    @scene.draw
  end

  def add_hover_ability
    @scene.on_hover_exit
    @scene.on_hover
  end

  def add_mouse_controls
    @scene.on_click if button_down? Gosu::MsLeft
  end
end

$window = GameWindow.new
$window.show
