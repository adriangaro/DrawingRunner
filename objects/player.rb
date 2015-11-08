class Player < Obj
  attr_accessor :shape, :body, :animation, :can_jump
  def initialize(space)
    super space
    @animation = Animation.new "resources/images/props/Player_", 10, 0.5
    @body = CP::Body.new 10, Float::INFINITY
    @vertices = [vec2(0, 0), vec2(50, 0), vec2(50, -100), vec2(0, -100)]
    @shape = CP::Shape::Poly.new @body,
                                 @vertices,
                                 vec2(-25, 50)
    @shape.e = 0
    @shape.u = 0
    @shape.collision_type = :player
    @factor = Point[50 * 1.0 / @animation.width, 100 * 1.0 / @animation.height]
    add_to_space
    @can_jump = false
  end

  def update
    @body.apply_force(vec2(200, 000), vec2(0, 0))
  end

  def jump
    @body.apply_impulse(vec2(0, -800), vec2(0, 0)) if(@can_jump)
  end

  def draw(offset)
    @animation.next_frame.draw_rot(offset.x + @body.p.x, offset.y + @body.p.y, 1, @body.a / Math::PI * 180, 0.5, 0.5, @factor.x, @factor.y)
  end
end
