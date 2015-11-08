class Floor < Obj
  attr_accessor :shape, :body, :image
  def initialize(space)
    super space
    @image = Gosu::Image.new "resources/images/props/floor.png"
    @body = CP::Body.new(Float::INFINITY, Float::INFINITY)
    @body.a = 0
    @shape = CP::Shape::Poly.new @body,
                                 [vec2(0, 0), vec2(2000, 0), vec2(2000, -10), vec2(0, -10)],
                                 vec2(0, 10)
    @shape.e = 0
    @shape.collision_type = :ground
    @factor = Point[2000 * 1.0 / @image.width, 10 * 1.0 / @image.height]
    add_to_space
  end

  def draw(offset)
    @image.draw(offset.x + @body.p.x, offset.y + @body.p.y, 1, @factor.x, @factor.y)
  end
end
