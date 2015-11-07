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
                             vec2(25, -50))
  end
end
