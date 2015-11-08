class Animation
  attr_accessor :size, :current_frame, :width, :height, :speed
  def initialize(source, size, speed = 1)
    @speed = speed
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
    @current_frame += 1 * @speed
    if @current_frame == @size
      @current_frame = 0
    end

    @aux
  end
end

class Point
  def self.[](x, y)
    self.new x, y
  end

  attr_accessor :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end

  def to_vec2
    vec2(@x, @y)
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

class CP::Vec2
  def to_point
    Point[x, y]
  end
end
