package
{
   import flash.display.Sprite;
   
   public class UIHandler extends Sprite
   {
      
      public static var self:UIHandler;
      
      public static var paused:Boolean = false;
       
      
      public var gMode:GameMode;
      
      public function UIHandler(param1:GameMode)
      {
         super();
         this.gMode = param1;
         self = this;
         new PopupHandler(this);
         new ToastHandler(this);
         new CollectionHandler(this);
         new SliderHandler(this);
         new FadeHandler(this);
         new PuffHandler(this);
         new StatusHandler(this);
         new EffectIndicator(this);
         new WipeHandler(this);
         new DebugMenu(this);
      }
      
      public static function pauseUpdated() : void
      {
         if(World.currentLevel != null && !World.currentLevel.inEditor && !World.stepLock && !GameMode.gameMode.worldLocked)
         {
            GameMode.playing = !paused;
         }
      }
      
      public static function unPause() : void
      {
         paused = false;
         pauseUpdated();
      }
      
      public static function togglePause() : void
      {
         paused = !paused;
         pauseUpdated();
      }
      
      public function frame() : *
      {
         this.drawLevelString();
         this.orderWindows();
         FadeHandler.checkFades();
         PuffHandler.checkPuffs();
         StatusHandler.tick();
      }
      
      public function orderWindows() : *
      {
         this.gMode.setChildIndex(SpriteUtils.bgClip,0);
         this.gMode.setChildIndex(SpriteUtils.gameClip,this.gMode.numChildren - 1);
         if(SpriteUtils.transferClip)
         {
            this.gMode.setChildIndex(SpriteUtils.transferClip,this.gMode.numChildren - 1);
         }
         this.gMode.setChildIndex(this,this.gMode.numChildren - 1);
         this.gMode.setChildIndex(this.gMode.dbgText2,this.gMode.numChildren - 1);
         this.gMode.setChildIndex(this.gMode.dbgText,this.gMode.numChildren - 1);
         setChildIndex(PopupHandler.self,numChildren - 1);
         setChildIndex(StatusHandler.self,numChildren - 1);
         setChildIndex(ToastHandler.self,numChildren - 1);
         setChildIndex(EffectIndicator.self,numChildren - 1);
         StatusHandler.btnMenuReset.visible = World.currentLevel.myID >= Level.LEVEL_1;
         StatusHandler.btnMenuExit.visible = World.currentLevel.myID >= Level.LEVEL_1;
         StatusHandler.btnMenuSound.visible = World.currentLevel.myID >= Level.LEVEL_1;
         StatusHandler.btnMenuMusic.visible = World.currentLevel.myID >= Level.LEVEL_1;
         if(WipeHandler.activeSwipe != null)
         {
            setChildIndex(WipeHandler.activeSwipe,numChildren - 1);
         }
         setChildIndex(DebugMenu.self,numChildren - 1);
      }
      
      public function cleanup() : *
      {
         CollectionHandler.cleanup();
         PuffHandler.cleanup();
         FadeHandler.cleanup();
         StatusHandler.cleanup();
      }
      
      public function buttonPressed(param1:String) : *
      {
         this.gMode.buttonPressed(param1);
         switch(param1)
         {
            case "iconMS":
               this.gMode.sounds.toggleSound();
               this.gMode.sounds.toggleMusic();
               break;
            case "iconSM":
               this.gMode.sounds.toggleSound();
               this.gMode.sounds.toggleMusic();
               break;
            case "iconS":
               this.gMode.sounds.toggleSound();
               break;
            case "iconM":
               this.gMode.sounds.toggleMusic();
               break;
            case "iconR":
               if(World.currentLevel.controlable)
               {
                  LevelUtils.initLevel(World.currentLevel.myID);
                  break;
               }
               break;
            case "iconX":
               this.gMode.newGame();
               break;
            case "Deletelast":
               LevelUtils.deleteLast();
               break;
            case "Savelevel":
               LevelUtils.generateLevelString();
               break;
            case "btn_garage":
               GameMode.gameMode.showCharSelect();
               break;
            case "pause":
               togglePause();
               break;
            case "help":
               GameMode.gameMode.showHelp();
               break;
            case "mainmenu":
               GameMode.gameMode.showIntroMenu();
         }
      }
      
      public function drawLevelString() : *
      {
      }
   }
}
