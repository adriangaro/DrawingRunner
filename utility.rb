class Animation
  attr_accessor :size, :current_frame
  def initialize(source, size)
    @size = size
    @frames = []
    size.times do |x|
      @frames << Gosu::Image.new(source + x + ".png")
    end
    @frame = 0
  end

  def next_frame
    @aux = @frames[@current_frame]
    if @current_frame == @number
      @current_frame = 0
    else
      @current_frame += 1
    end

    @aux
  end
end

def vec2(x, y)
  CP::Vec2.new x, y
end
