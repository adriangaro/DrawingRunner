require_relative "requires"

$skin = Gosu::Image.new("resources/images/props/Player.png")

class GameWindow < Gosu::Window
  attr_accessor :scene, :music, :scenes, :sfx, :menu_music, :sfx_buton, :offset
  def initialize
    super 640, 480, true
    @offset = Point[0, 0]
    @music = true;
    @menu_music = Gosu::Song.new(self, "resources/music/menu_music.wav")
    @sfx_buton = Gosu::Song.new(self, "resources/sfx/button_sound.wav")
    @menu_music.play(looping = true)
    @sfx = true;
    @scene = MenuScene.new self
    @scenes = {}
    @scenes[@scene.class] = @scene
  end

  def update
    add_keyboard_controls
    add_mouse_controls
    add_hover_ability
    @scene.update
    @offset = @scene.offset
  end

  def add_keyboard_controls
    @scene.keyboard_controls
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
    @scene.on_click_exit if !button_down? Gosu::MsLeft
  end
end

$window = GameWindow.new
$window.show
