class Drawing < Obj
  attr_accessor :initialized, :points, :timer
  def initialize(space)
    super space
    @body = []
    @shape = []
    @joint = []
    @points = []
    @factors = []
    @angles = []
    @timer = 0
    @image = Gosu::Image.new "resources/images/props/floor.png"
  end

  def add_point(mouse)
    @points << mouse
  end

  def clear
    @space.remove_body(@body)
    @shape.each do |x|
        @space.remove_shape(x)
    end
  end

  def create_drawing
    (@points.length - 1).times do |i|
      @body << CP::Body.new(100, 30)
      @body[i].p = @points[i].to_vec2
    end

    for i in 0...(@points.length - 1) do
      len =  vec2(@points[i + 1].x - @points[i].x, -(@points[i + 1].y - @points[i].y))
      shape = CP::Shape::Segment.new(@body[i], vec2(0, 0), len, 10)
      shape.collision_type = :ground
      @shape << shape
      shape = CP::Shape::Circle.new(@body[i], 5, vec2(0, 0))
      shape.collision_type = :ground
      @shape << shape
      @factors << Point[len.length * 1.0 / @image.width, 1]
      @angles << -len.to_angle / Math::PI * 180
    end

    add_to_space
  end

  def update
    @timer += 1
  end

  def add_to_space
    @shape.each do |s|
      @space.add_shape s
    end
  end

  def draw(offset)
    for i in 0...@body.length do
      @image.draw_rot(@body[i].p.x + offset.x, @body[i].p.y + offset.y, 1, @angles[i], 0, 0.5, @factors[i].x, 1)
    end
  end
end
