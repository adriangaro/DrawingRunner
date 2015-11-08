class MenuScene < Scene
  def initialize(window)
    super window


    #BACKGROUND
    @background = Gosu::Image.new("resources/images/interface/main_menu_bg.jpg")

    #LOGO
    @logo = Gosu::Image.new("resources/images/interface/menu_big_logo.png")

    #START BUTTON
    @button_start = Button.new(@window.width / 2,@window.height / 3 , 125 , 40 ,"resources/images/interface/button_start_default.png")
    @button_start.on_click_block = lambda {
      @window.scene = @window.scenes[GameScene] == nil ? GameScene.new(@window) : @window.scenes[GameScene]
    }
    @button_start.on_hover_block = lambda { @button_start.image = Gosu::Image.new("resources/images/interface/button_start_hover.png") }
    @button_start.on_hover_exit_block = lambda { @button_start.image = Gosu::Image.new("resources/images/interface/button_start_default.png") }

    @buttons << @button_start


    #INFO BUTTON
    @button_info = Button.new(@window.width / 2,@window.height / 2.20 ,125 , 40 ,"resources/images/interface/button_info_default.png")
    @button_info.on_hover_block = lambda { @button_info.image = Gosu::Image.new("resources/images/interface/button_info_hover.png") }
    @button_info.on_hover_exit_block = lambda { @button_info.image = Gosu::Image.new("resources/images/interface/button_info_default.png") }
    @button_info.on_click_block = lambda {
      @window.scene = @window.scenes[InfoScene] == nil ? InfoScene.new(@window) : @window.scenes[InfoScene]
    }
    @buttons << @button_info

    #CREDIT BUTTON
    @button_credits = Button.new(@window.width / 2,@window.height / 1.75 , 125 , 40 ,"resources/images/interface/button_credits_default.png")
    @button_credits.on_hover_block = lambda { @button_credits.image = Gosu::Image.new("resources/images/interface/button_credits_hover.png") }
    @button_credits.on_hover_exit_block = lambda { @button_credits.image = Gosu::Image.new("resources/images/interface/button_credits_default.png") }
    @button_credits.on_click_block = lambda {
      @window.scene = @window.scenes[CreditsScene] == nil ? CreditsScene.new(@window) : @window.scenes[CreditsScene]
    }
    @buttons << @button_credits


    #SELECT SKIN
    @button_skins = Button.new(@window.width / 2, @window.height / 1.30, 125, 40 ,"resources/images/interface/button_credits_default.png")
    @button_skins.on_click_block = lambda {
      @window.scene = @window.scenes[SkinsScene] == nil ? SkinsScene.new(@window) : @window.scenes[SkinsScene]
    }
    @buttons << @button_skins



    #SETTING BUTTON
    @button_settings = Button.new(@window.width / 1.10,@window.height / 1.10 , 40 , 40 ,"resources/images/interface/button_settings_default.png")
    @button_settings.on_click_block = lambda {
      @window.scene = @window.scenes[SettingsScene] == nil ? SettingsScene.new(@window) : @window.scenes[SettingsScene]
    }
    @button_settings.on_hover_block = lambda { @button_settings.image = Gosu::Image.new("resources/images/interface/button_settings_hover.png") }
    @button_settings.on_hover_exit_block = lambda { @button_settings.image = Gosu::Image.new("resources/images/interface/button_settings_default.png") }

    @buttons << @button_settings

    #BOUNCING Animation Left
    @anim_bounce_left = Animation.new("resources/images/interface/bouncing/bouncing" , 25);

    #BOUNCING Animation Right
    @anim_bounce_right = Animation.new("resources/images/interface/bouncing/bouncing" , 25);

end

  def draw
    @background.draw(0,0,0, @window.width*1.0/@background.width, @window.height*1.0/@background.height)
    @logo.draw(15,0,1, @window.width*1.0/@background.width, @window.height*1.0/@background.height)
    @anim_bounce_left.next_frame.draw(0,0,1, 100*1.0/@anim_bounce_left.width, 100*1.0/@anim_bounce_left.height)
    @anim_bounce_right.next_frame.draw(@window.width+15,0,1, -100*1.0/@anim_bounce_right.width, 100*1.0/@anim_bounce_right.height)
    @buttons.each do |but|
      but.draw
    end
  end
end
