class SkinsScene < Scene
  def initialize(window)
    super window
    #BACKGROUND
    @background = Gosu::Image.new("resources/images/interface/main_menu_bg.jpg")

    #SETTINGS LOGO
    #@logo = Gosu::Image.new("resources/images/interface/settings_big_logo.png")

    #BACK BUTTON
    @button_back_to_menu = Button.new(@window.width / 7.5, @window.height/8.5 , 70 , 40 ,"resources/images/interface/back_arrow.png")
    @button_back_to_menu.on_click_block = lambda { @window.scene = @window.scenes[MenuScene] == nil ? MenuScene.new(@window) : @window.scenes[MenuScene]}
  #  @button_back_to_menu.on_hover_block = lambda { @button_back_to_menu.image = Gosu::Image.new("resources/images/interface/back_arrow.png") }
  #  @button_back_to_menu.on_hover_exit_block = lambda { @button_back_to_menu.image = Gosu::Image.new("resources/images/interface/back_arrow.png") }

    @buttons << @button_back_to_menu

    #READ FROM FILE
    @skin_list = []
    f = File.open("player_settings/skin_list.txt" , "r")
    f.each_line { |line|
      @skin_list << line.chomp;
    }
    f.close
    @i = 0

    #SELECT BUTTON

    #NEXT SKIN

    @button_previous_skin = Button.new(@window.width/2.5, @window.height/1.2 , 40 , 40 ,"player_settings/skin_resources/arrow/left.png")
    @button_previous_skin.on_click_block = lambda { @i += 1}
    @buttons << @button_previous_skin

    #PREVIOUS SKIN

    @button_next_skin = Button.new(@window.width/1.9, @window.height/1.2 , 40 , 40 ,"player_settings/skin_resources/arrow/right.png")
    @button_next_skin.on_click_block = lambda { @i -= 1 }
    @buttons << @button_next_skin

    #SKIN PREVIEW DEFAULT

    @skin_default =   Gosu::Image.new("player_settings/skin_resources/default/"+ @skin_list[@i] + ".png")


  end

  def update
    if(@i < 0)
      @i = @skin_list.length - 1
    elsif @i >= @skin_list.length
      @i = 0
    end
    @skin_default = Gosu::Image.new("player_settings/skin_resources/default/"+ @skin_list[@i] + ".png")
    $skin = @skin_default
  end

  def draw
    @background.draw(0,0,0, @window.width*1.0/@background.width, @window.height*1.0/@background.height)
    @skin_default.draw(@window.width/3,@window.height/3,2, @window.width / 3.0 / @skin_default.width, @window.height / 3.0 / @skin_default.height  )
    #@logo.draw(15,0,1, @window.width*1.0/@background.width, @window.height*1.0/@background.height)
    @buttons.each do |but|
      but.draw
    end
  end

end
