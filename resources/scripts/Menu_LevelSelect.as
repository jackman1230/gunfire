package
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   
   public class Menu_LevelSelect extends PopupMenu
   {
      
      public static var selectActive:Boolean = false;
       
      
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
      
      public var levelIndex:int = 0;
      
      public var garageButton:Sprite;
      
      public var flicked:Boolean = false;
      
      public var followOffset:int = 30;
      
      public function Menu_LevelSelect(param1:GameMode, param2:PopupHandler)
      {
         gMode = param1;
         this.popupHandler = param2;
         hasClickGuard = false;
         super();
         var _loc3_:slug_instructions_thingie = new slug_instructions_thingie();
         addChild(_loc3_);
         zoomChild = _loc3_;
         Camera.setCamPos(640,0,true);
         if(titleFont)
         {
            titleFont.visible = false;
         }
         _loc3_.btn01.addEventListener(MouseEvent.MOUSE_UP,this.clickyUp);
         gMode.keyMenu = this;
      }
      
      public function clickyUp(param1:Event = null) : void
      {
         this.buttonPressed("btn_level0");
      }
      
      override public function keyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER || param1.keyCode == 82)
         {
            this.buttonPressed("btn_level" + this.levelIndex.toString());
         }
      }
      
      override public function popup() : void
      {
         super.popup();
         selectActive = true;
      }
      
      override public function frame(param1:Event) : void
      {
         super.frame(param1);
         this.frameCount++;
         var _loc2_:Number = Math.sin(this.frameCount / 4) * 0.1;
         if(!this.flicked)
         {
            if(direction == DIRECTION_UP)
            {
               if(World.currentLevel.myID >= Level.LEVEL_1)
               {
                  this.flicked = true;
                  World.stopTicking = true;
               }
            }
         }
      }
      
      override public function buttonPressed(param1:String) : void
      {
         switch(param1)
         {
            case "btn_level0":
               this.initLevel(Level.LEVEL_1);
               break;
            case "btn_level1":
               this.initLevel(Level.LEVEL_2);
               break;
            case "btn_level2":
               this.initLevel(Level.LEVEL_3);
               break;
            case "btn_level3":
               this.initLevel(Level.LEVEL_4);
               break;
            case "btn_level4":
               this.initLevel(Level.LEVEL_5);
               break;
            case "btn_level5":
               this.initLevel(Level.LEVEL_6);
               break;
            case "btn_level6":
               this.initLevel(Level.LEVEL_7);
               break;
            case "btn_level7":
               this.initLevel(Level.LEVEL_8);
               break;
            case "btn_level8":
               this.initLevel(Level.LEVEL_9);
               break;
            case "btn_level9":
               this.initLevel(Level.LEVEL_10);
               break;
            case "btn_level10":
               this.initLevel(Level.LEVEL_11);
               break;
            case "btn_level11":
               this.initLevel(Level.LEVEL_12);
               break;
            case "btn_level12":
               this.initLevel(Level.LEVEL_13);
               break;
            case "btn_score0":
               MochiConnect.staticSelf.showScores(0);
               break;
            case "btn_score1":
               MochiConnect.staticSelf.showScores(1);
               break;
            case "btn_score2":
               MochiConnect.staticSelf.showScores(2);
               break;
            case "btn_score3":
               MochiConnect.staticSelf.showScores(3);
               break;
            case "btn_score4":
               MochiConnect.staticSelf.showScores(4);
               break;
            case "btn_score5":
               MochiConnect.staticSelf.showScores(5);
               break;
            case "btn_score6":
               MochiConnect.staticSelf.showScores(6);
               break;
            case "btn_score7":
               MochiConnect.staticSelf.showScores(7);
               break;
            case "btn_score8":
               MochiConnect.staticSelf.showScores(8);
               break;
            case "btn_score9":
               MochiConnect.staticSelf.showScores(9);
               break;
            case "btn_score10":
               MochiConnect.staticSelf.showScores(10);
               break;
            case "btn_score11":
               MochiConnect.staticSelf.showScores(11);
               break;
            case "btn_score12":
               MochiConnect.staticSelf.showScores(12);
               break;
            case "btn_garage":
               GameMode.gameMode.showCharSelect();
               break;
            case "btn_menu":
               GameMode.gameMode.showIntroMenu();
         }
         super.buttonPressed(param1);
      }
      
      public function launchURL(param1:String) : void
      {
         gMode.launchURL(param1);
      }
      
      override public function popDown(param1:Boolean = false) : void
      {
         super.popDown(param1);
         if(World.currentLevel != null)
         {
            if(World.currentLevel.myID >= Level.LEVEL_1)
            {
               World.stopTicking = false;
            }
         }
      }
      
      public function initLevel(param1:int = 0) : void
      {
         if(World.currentLevel.myID >= Level.LEVEL_1)
         {
            this.popDown();
         }
         else
         {
            LevelUtils.initLevel(param1);
         }
      }
   }
}
