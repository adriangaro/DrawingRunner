class InfoScene < Scene
  def initialize(window)
    super window

    #BACKGROUND
    @background = Gosu::Image.new("resources/images/interface/main_menu_bg.jpg")

    #LOGO
    @logo = Gosu::Image.new("resources/images/interface/info_big_logo.png")

    #INFOS
    @infos = Gosu::Image.new("resources/images/interface/infos.png")

    #BACK BUTTON
    @button_back_to_menu = Button.new(@window.width / 7.5, @window.height/8.5 , 70 , 40 ,"resources/images/interface/back_arrow.png")
    @button_back_to_menu.on_click_block = lambda { @window.scene = @window.scenes[MenuScene] == nil ? MenuScene.new(@window) : @window.scenes[MenuScene]}

    @buttons << @button_back_to_menu

  end

    def draw
      @background.draw(0,0,0, @window.width*1.0/@background.width, @window.height*1.0/@background.height)
      @logo.draw(15,0,1, @window.width*1.0/@background.width, @window.height*1.0/@background.height)
      @infos.draw(15,50,1, @window.width*1.0/@infos.width, @window.height*1.0/@infos.height/1.1)
      @buttons.each do |but|
        but.draw
      end
    end

end
