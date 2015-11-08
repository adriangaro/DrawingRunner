class Obj
  attr_accessor :shape, :body
  def initialize(space)
    @space = space
  end

  def add_to_space
    @space.add_body @body unless @body.mass == Float::INFINITY
    @space.add_shape @shape
  end

  def warp(point)
    if point.is_a? Point
      @body.p = point.to_vec2
    else
      @body.p = point
    end
  end

  def clear
  end

  def update
  end

  def draw(offset)
  end
end
