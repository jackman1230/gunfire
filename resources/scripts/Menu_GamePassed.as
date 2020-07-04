package
{
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   
   public class Menu_GamePassed extends PopupMenu
   {
       
      
      public var popupHandler:PopupHandler;
      
      public var bg:gamecomplete_background;
      
      public var scoreCounter:int = 0;
      
      public var calculatedTotalScore:int = 0;
      
      public var fc:int = 0;
      
      public function Menu_GamePassed(param1:GameMode, param2:PopupHandler)
      {
         gMode = param1;
         this.popupHandler = param2;
         hasClickGuard = false;
         super();
         this.bg = new gamecomplete_background();
         addChild(this.bg);
         zoomChild = this.bg;
         if(titleFont)
         {
            titleFont.visible = false;
         }
         this.bg.btn01.addEventListener(MouseEvent.MOUSE_UP,this.submitClicked);
         this.bg.btn02.addEventListener(MouseEvent.MOUSE_UP,this.moreGamesClicked);
         this.calculatedTotalScore = ScoreHandler.calculateTotalScore(true);
         gMode.keyMenu = this;
         SoundHandler.playSoundClass(sound_pickup_life);
      }
      
      public function submitClicked(param1:Event = null) : void
      {
         this.buttonPressed("btn_submitscore");
      }
      
      public function moreGamesClicked(param1:Event = null) : void
      {
         this.buttonPressed(global.pmg_button_command_regular);
      }
      
      override public function keyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER || param1.keyCode == 82)
         {
            this.buttonPressed("btn_continue");
         }
      }
      
      override public function frame(param1:Event) : void
      {
         super.frame(param1);
         if(this.scoreCounter < this.calculatedTotalScore)
         {
            this.scoreCounter = this.scoreCounter + (this.calculatedTotalScore - this.scoreCounter) / 10;
            if(this.calculatedTotalScore - this.scoreCounter < 10)
            {
               this.scoreCounter = this.calculatedTotalScore;
            }
            this.bg.scoretext.htmlText = this.scoreCounter.toString();
         }
         this.fc++;
      }
      
      override public function buttonPressed(param1:String) : void
      {
         if(param1 == "btn_menu")
         {
            ScoreHandler.cleanupEverything();
         }
         Serialiser.saveStats();
         GameMode.gameMode.newGame();
         if(param1 == "btn_tractor2")
         {
            Main.self.launchURL(global.url_BatmanTruck1);
         }
         if(param1 == "btn_submitscore")
         {
            GameMode.gameMode.submitScore(ScoreHandler.calculateTotalScore());
            GameMode.gameMode.showIntroMenu();
         }
         super.buttonPressed(param1);
      }
      
      public function yespressed() : void
      {
         this.nopressed();
      }
      
      public function nopressed() : void
      {
         ScoreHandler.cleanupEverything();
         GameMode.gameMode.showIntroMenu();
      }
   }
}
