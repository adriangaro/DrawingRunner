class SettingsScene < Scene
  def initialize(window)
    super window
    #BACKGROUND
    @background = Gosu::Image.new("resources/images/interface/main_menu_bg.jpg")

    #SETTINGS LOGO
    @logo = Gosu::Image.new("resources/images/interface/settings_big_logo.png")

    #BACK BUTTON
    @button_back_to_menu = Button.new(@window.width / 7.5, @window.height/8.5 , 70 , 40 ,"resources/images/interface/back_arrow.png")
    @button_back_to_menu.on_click_block = lambda { @window.scene = @window.scenes[MenuScene] == nil ? MenuScene.new(@window) : @window.scenes[MenuScene]}
  #  @button_back_to_menu.on_hover_block = lambda { @button_back_to_menu.image = Gosu::Image.new("resources/images/interface/back_arrow.png") }
  #  @button_back_to_menu.on_hover_exit_block = lambda { @button_back_to_menu.image = Gosu::Image.new("resources/images/interface/back_arrow.png") }
    
    @buttons << @button_back_to_menu


    #MUSIC BUTTON
    @button_music = Button.new(@window.width / 2,@window.height / 3.2 , 125 , 40 ,"resources/images/interface/music_" + (@window.music ? "on" : "off") + ".png")
    @button_music.on_click_block = lambda {
      @window.music = !@window.music
      @window.sfx ? @window.sfx_buton.play : true
      @button_music.image = Gosu::Image.new("resources/images/interface/music_" + (@window.music ? "on" : "off" ) + ".png")
      @window.music ? @window.menu_music.play(looping = true)  : @window.menu_music.stop

    }

    @buttons << @button_music

    #SFX BUTTON
    @button_sfx = Button.new(@window.width / 2,@window.height / 2.2 , 125 , 40 ,"resources/images/interface/sfx_" + (@window.sfx ? "on" : "off") + ".png")
    @button_sfx.on_click_block = lambda {
      @window.sfx = !@window.sfx
      @button_sfx.image = Gosu::Image.new("resources/images/interface/sfx_" + (@window.sfx ? "on" : "off") + ".png")
    }

    @buttons << @button_sfx

  end

  def draw
    @background.draw(0,0,0, @window.width*1.0/@background.width, @window.height*1.0/@background.height)
    @logo.draw(15,0,1, @window.width*1.0/@background.width, @window.height*1.0/@background.height)
    @buttons.each do |but|
      but.draw

    end
  end

end
