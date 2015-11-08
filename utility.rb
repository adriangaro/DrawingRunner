class Animation
  attr_accessor :size, :current_frame, :width, :height
  def initialize(source, size)
    @size = size
    @frames = []
    size.times do |x|
      @frames << Gosu::Image.new(source + (x + 1).to_s + ".png")
    end
    @width = @frames[0].width
    @height = @frames[0].height
    @current_frame = 0
  end

  def next_frame
    @aux = @frames[@current_frame]
    @current_frame += 1
    if @current_frame == @size - 1
      @current_frame = 0
    end

    @aux
  end
end
#Animation.new("resources/images/menu/")
class Point
  def self.[](x, y)
    self.new x, y
  end

  attr_accessor :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end
end

class Numeric
  def radians_to_vec2
    CP::Vec2.new Math::cos(self), Math::sin(self)
  end
end

def vec2(x, y)
  CP::Vec2.new x, y
end
