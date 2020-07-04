package
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   import objects.cCar;
   
   public class Menu_LevelFailed extends PopupMenu
   {
       
      
      public var popupHandler:PopupHandler;
      
      public var playButton:iButton;
      
      public var freePlayButton:iButton;
      
      public var i6Button:iButton;
      
      public var i6Button2:iButton;
      
      public var totalScoreA:customFont;
      
      public var totalScoreB:customFont;
      
      public var frameCount:int = 0;
      
      public var titleClip:Sprite;
      
      public var launchedCubes:Boolean = false;
      
      public function Menu_LevelFailed(param1:GameMode, param2:PopupHandler, param3:Boolean = false)
      {
         gMode = param1;
         this.popupHandler = param2;
         hasClickGuard = false;
         super();
         SlugScore.lastLives = (World.followObj as cCar).slug_lives;
         var _loc4_:temp_outroimage = new temp_outroimage();
         addChild(_loc4_);
         zoomChild = _loc4_;
         _loc4_.btn01.addEventListener(MouseEvent.MOUSE_UP,this.retryButton);
         _loc4_.btn02.addEventListener(MouseEvent.MOUSE_UP,this.moreGamesButton);
         GameMode.gameMode.sounds.stopMusic();
         SoundHandler.playSoundClass(sound_gameover);
         gMode.keyMenu = this;
      }
      
      public function retryButton(param1:Event = null) : void
      {
         this.buttonPressed("btn_continue");
      }
      
      public function moreGamesButton(param1:Event = null) : void
      {
         this.buttonPressed(global.pmg_button_command_menu);
      }
      
      override public function popup() : void
      {
         super.popup();
      }
      
      override public function keyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER || param1.keyCode == 82)
         {
            this.buttonPressed("btn_continue");
         }
      }
      
      override public function buttonPressed(param1:String) : void
      {
         switch(param1)
         {
            case "btn_continue":
               this.continuePressed();
               break;
            case "iconX":
               GameMode.gameMode.showLevelSelect();
               break;
            case "btn_retry":
               this.continuePressed();
         }
         super.buttonPressed(param1);
      }
      
      public function continuePressed() : void
      {
         PopupHandler.clearMenus(true);
         LevelUtils.initLevel(World.currentLevel.myID);
         GameMode.gameMode.sounds.playMusic();
      }
   }
}
