class Scene
  attr_accessor :buttons
  def initialize(window)
    @window = window
    @buttons = []
  end

  def update
  end

  def draw
  end

  def on_click
    @mouse = Point[$window.mouse_x, $window.mouse_y]
    @buttons.each do |but|
      but.on_click if (@mouse.x - but.x).abs <= but.width / 2 && (@mouse.y - but.y).abs <= but.height / 2
    end
  end

  def on_hover
    @mouse = Point[$window.mouse_x, $window.mouse_y]
    @buttons.each do |but|
      if (@mouse.x - but.x).abs <= but.width / 2 && (@mouse.y - but.y).abs <= but.height / 2
        but.on_hover
        but.hovered = true
      else
        but.hovered = false
      end
    end
  end

  def on_hover_exit
    @mouse = Point[$window.mouse_x, $window.mouse_y]
    @buttons.each do |but|
      but.on_hover_exit if (@mouse.x - but.x).abs > but.width / 2 && (@mouse.y - but.y).abs > but.height / 2 && but.hovered
    end
  end
end
