class Player < Obj
  attr_accessor :shape, :body, :image, :can_jump, :dir
  def initialize(space)
    super space
    @image = $skin
    @body = CP::Body.new 10, 10

    @shape = CP::Shape::Circle.new(@body, 25, vec2(0, 0))
    @shape.e = 0
    @shape.collision_type = :player
    @body.w_limit = 10
    @factor = Point[50 * 1.0 / @image.width, 50 * 1.0 / @image.height]
    add_to_space
    @can_jump = false
    @dir = 1
  end

  def update(delta)
    coef = 1.05 ** (delta / 300)
    @body.t = 10  * @dir * coef
    @body.apply_force(vec2(800, 0) * @dir * coef, vec2(0, 0))
  end

  def jump
    if(@can_jump)
      @body.apply_impulse(vec2(0, -800), vec2(0, 0))
    else
      res = false
      query = @space.segment_query(@body.p + vec2(25, 0) * @dir, @body.p + vec2(30, 0) * @dir, CP::ALL_LAYERS, CP::NO_GROUP)  do |shape, t, n|
        res = res || shape.collision_type == :ground
      end
      if(res)
        @body.apply_impulse(vec2(- @dir * 600, -600), vec2(0, 0))
        @dir = -@dir
      end
    end
  end

  def draw(offset)
    @image.draw_rot(offset.x + @body.p.x, offset.y + @body.p.y, 1, @body.a / Math::PI * 180, 0.5, 0.5, @factor.x, @factor.y)
  end
end
