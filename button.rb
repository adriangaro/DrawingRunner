class Button
  attr_accessor :on_click_block, :on_hover_block, :on_hover_exit_block, :hovered, :x, :y, :width, :height, :image
  def initialize(x, y, width, height, source)
    @x = x
    @y = y
    @width = width
    @height = height
    @image = Gosu::Image.new source
    @hovered = false
  end

  def draw
    @image.draw(@x - @width / 2, @y - @height / 2 , 1, @width*1.0/@image.width, @height*1.0/@image.height )
  end

  def on_click()
    @on_click_block.call if @on_click_block != nil
  end

  def on_hover()
    @on_hover_block.call if @on_hover_block != nil
  end

  def on_hover_exit()
    @on_hover_exit_block.call if @on_hover_exit_block != nil
  end

end

# Button.new(0,0,100,100,path_string) do
#    define_method("on_click") do
#
#    end

#    define_method("on_hover") do
#    end
# end
