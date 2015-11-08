class Player < Obj
  attr_accessor :shape, :body, :animation, :can_jump
  def initialize(space)
    super space
    @image = Gosu::Image.new "resources/images/props/Player.png"
    @body = CP::Body.new 10, 10

    @shape = CP::Shape::Circle.new(@body, 25, vec2(0, 0))
    @shape.e = 0
    @shape.collision_type = :player
    @body.w_limit = 10
    @factor = Point[50 * 1.0 / @image.width, 50 * 1.0 / @image.height]
    add_to_space
    @can_jump = false
  end

  def update
    @body.t = 10
    @body.apply_force(vec2(800, 0), vec2(0, 0))
  end

  def jump
    @body.apply_impulse(vec2(0, -800), vec2(0, 0)) if(@can_jump)
  end

  def draw(offset)
    @image.draw_rot(offset.x + @body.p.x, offset.y + @body.p.y, 1, @body.a / Math::PI * 180, 0.5, 0.5, @factor.x, @factor.y)
  end
end
