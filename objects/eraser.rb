class Eraser < Obj
  def initialize(space, final)
    super(space)
    @image = Gosu::Image.new "resources/images/props/eraser.png"
    @final = final
    @y = 0
    @dir = 1
    @factor = Point[100.0 / @image.width, 60.0 / @image.height]
    @particle_emitter = Ashton::ParticleEmitter.new(20, 0, 3, image: Gosu::Image.new("resources/images/props/cloud.png"), scale: 0.2, speed: 20, friction: 0.5, max_particles: 200, interval: 0.1, angular_velocity: 20..50, fade: 57)
  end

  def update
    @y += 5 * @dir
    if(@y < 0 || @y > @final)
      @dir = -@dir
    end
    @last_update_at ||= Gosu::milliseconds
    delta = [Gosu::milliseconds - @last_update_at, 100].min * 0.001 # Limit delta to 100ms (10fps), in case of freezing.
    @particle_emitter.update delta
    @particle_emitter.y = @y
  end

  def draw(offset)
    @image.draw 0, @y - 60, 2, @factor.x, @factor.y
    @particle_emitter.draw
  end
end
