class PlayerGroundCollisionHandler
  def initialize(scene)
    @scene = scene
  end

  def begin(a, _b, arbiter)
    @scene.player.can_jump = true if arbiter.normal(0).y > 0
    true
  end

  def separate

    @scene.player.can_jump = false
  end
end
