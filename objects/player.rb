class Player
  attr_accessor :shape, :body, :animation
  def initialize
    @animation = Animation.new "resources/player", 5
    @body = CP::Body.new 10, 1
    @vertices = [vec2(-100.0, 0.0),
                 vec2(-100.0, 50.0),
                 vec2(0.0, 50.0),
                 vec2(0.0, 0.0)]
    @shape = CP::Shape::Poly @body,
                             @vertices,
                             vec2(25, -50)
    @factor = Point[@animation.width * 1.0 / 50, @animation.height * 1.0 / 100]
  end

  def draw(offset)
    @animation.next_frame.draw(offset.x + @body.x, offset.y + @body.y, 1, @factor.x, @factor.y)
  end
end
