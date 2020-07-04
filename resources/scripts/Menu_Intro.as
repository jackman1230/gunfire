package
{
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   
   public class Menu_Intro extends PopupMenu
   {
       
      
      public var popupHandler:PopupHandler;
      
      public var frameCount:int = 0;
      
      public var logoStart:int;
      
      public var bg:fade_Intro;
      
      public var fadingBackground:Boolean = false;
      
      public var hasShownButtons:Boolean = false;
      
      public var fc:int = 0;
      
      public function Menu_Intro(param1:GameMode, param2:PopupHandler)
      {
         gMode = param1;
         this.popupHandler = param2;
         hasClickGuard = false;
         super();
         Camera.setCamPos(0,0,false);
         this.bg = new fade_Intro();
         addChild(this.bg);
         zoomChild = this.bg;
         if(titleFont)
         {
            titleFont.visible = false;
         }
         this.bg.play();
         gMode.keyMenu = this;
      }
      
      public function tgClick(param1:Event) : void
      {
         this.buttonPressed("btn_sponsor");
      }
      
      override public function keyDown(param1:KeyboardEvent) : void
      {
         if(this.hasShownButtons)
         {
            if(param1.keyCode == Keyboard.ENTER || param1.keyCode == 82)
            {
               this.buttonPressed("btn_play");
            }
         }
      }
      
      override public function popup() : void
      {
         super.popup();
      }
      
      override public function buttonPressed(param1:String) : void
      {
         if(param1 == "btn_play")
         {
            this.newGame();
         }
         if(param1 == "btn_tractor2")
         {
            Main.self.launchURL(global.url_BatmanTruck1);
         }
         if(param1 == "btn_clearstats")
         {
            GameMode.gameMode.showReset();
         }
         super.buttonPressed(param1);
      }
      
      public function newGame() : void
      {
         SlugScore.newGame();
         GameMode.gameMode.showLevelSelect();
      }
      
      override public function frame(param1:Event) : void
      {
         super.frame(param1);
         if(direction == DIRECTION_FULLY_UP)
         {
            GameMode.gameMode.submitScoreCache();
         }
         if(Migrate.buttonSafe)
         {
            Migrate.buttonSafe = false;
            this.fadingBackground = true;
            this.hasShownButtons = true;
            this.bg.btn_play.addEventListener(MouseEvent.MOUSE_UP,this.clickedPlay);
            this.bg.btn_highscores.addEventListener(MouseEvent.MOUSE_UP,this.clickedHighscore);
            this.bg.btn_download.addEventListener(MouseEvent.MOUSE_UP,this.clickedFGFYS);
            this.bg.btn_moregames.addEventListener(MouseEvent.MOUSE_UP,this.clickedMoreGames);
         }
         if(this.fadingBackground)
         {
            this.bg.backie.alpha = this.bg.backie.alpha - 0.05;
            if(this.bg.backie.alpha <= 0)
            {
               this.fadingBackground = false;
            }
         }
         this.fc++;
      }
      
      public function clickedPlay(param1:Event = null) : void
      {
         if(!GameMode.gameMode.sounds.playing)
         {
            GameMode.gameMode.sounds.playMusic();
         }
         this.buttonPressed("btn_play");
      }
      
      public function clickedHighscore(param1:Event = null) : void
      {
         this.buttonPressed("btn_highscores");
      }
      
      public function clickedFGFYS(param1:Event = null) : void
      {
         this.buttonPressed("btn_fgfys");
      }
      
      public function clickedMoreGames(param1:Event = null) : void
      {
         this.buttonPressed(global.pmg_button_command_menu);
      }
   }
}
