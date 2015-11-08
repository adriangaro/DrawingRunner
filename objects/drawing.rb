class Drawing < Obj
  attr_accessor :initialized, :point, :timer
  def initialize(space)
    super space
    @body = []
    @shape = []
    @joint = []
    @point
    @last_point
    @factors = []
    @angles = []
    @timer = 0
    @image = Gosu::Image.new "resources/images/props/floor.png"
  end

  def add_point(mouse)
    if(@point == nil)
      @point = mouse
    else
      @last_point = @point
      @point = mouse
      @body << CP::Body.new(Float::INFINITY, Float::INFINITY)
      i = @body.length - 1
      @body[i].p = @last_point.to_vec2
      len =  vec2(@point.x - @last_point.x, @point.y - @last_point.y)
      shape = CP::Shape::Segment.new(@body[i], vec2(0, 0), len, 5)
      shape.collision_type = :ground
      @shape << shape
      shape = CP::Shape::Circle.new(@body[i], 5, vec2(0, 0))
      shape.collision_type = :ground
      @shape << shape
      @factors << Point[len.length * 1.0 / @image.width, 1]
      @angles << len.to_angle / Math::PI * 180
    end
  end

  def clear
    @body.each do |b|
      @space.remove_body b
    end
    @shape.each do |x|
      @space.remove_shape(x)
    end
  end

  def create_drawing(offset)
    @body.each do |b|
      b.p = b.p - offset.to_vec2
    end

    add_to_space
    @initialized = true
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
    if(@initialized)
      for i in 0...@body.length do
        @image.draw_rot(@body[i].p.x + offset.x, @body[i].p.y + offset.y, 1, @angles[i], 0, 0.5, @factors[i].x, 1)
      end
    else
      for i in 0...@body.length  do
        @image.draw_rot(@body[i].p.x, @body[i].p.y, 1, @angles[i], 0, 0.5, @factors[i].x, 1)
      end
    end
  end
end
