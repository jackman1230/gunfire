package
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.ui.Keyboard;
   
   public class Menu_CharSelect extends PopupMenu
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
      
      public var levelIndex:int = 0;
      
      public var bg:menuBG_charSelect;
      
      public var niceTweenie:Tweenie;
      
      public var followOffset:int = 30;
      
      public function Menu_CharSelect(param1:GameMode, param2:PopupHandler)
      {
         var _loc13_:String = null;
         var _loc14_:customFont = null;
         var _loc15_:Sprite = null;
         gMode = param1;
         this.popupHandler = param2;
         hasClickGuard = false;
         super();
         this.bg = new menuBG_charSelect();
         addChild(this.bg);
         zoomChild = this.bg;
         World.followObj = null;
         Camera.setCamPos(1280,0,true);
         if(titleFont)
         {
            titleFont.visible = false;
         }
         makeButton(this.bg.back,"btn_back");
         var _loc3_:Array = [this.bg.char1,this.bg.char2,this.bg.char3,this.bg.char4];
         var _loc4_:Array = [null,null,null,null];
         var _loc5_:Array = [frame_char_1,frame_char_2,frame_char_3,frame_char_4];
         var _loc6_:Array = ["null","Unlocked at\nlevel 2","Unlocked at\nlevel 4","Unlocked at\nlevel 4"];
         var _loc7_:Array = ["Sandy\n Unlocked!","Squidward\n Unlocked!","Patrick\n Unlocked!","Spongebob!\n Unlocked!"];
         if(!this.onToonGames() && GameMode.thirdVehicleUnlocked)
         {
            _loc6_[3] = "See below";
         }
         var _loc8_:int = 0;
         _loc8_ = 0;
         while(_loc8_ < 4)
         {
            _loc13_ = "btn_" + _loc8_.toString();
            if(_loc8_ == 3 && !this.onToonGames() && GameMode.thirdVehicleUnlocked)
            {
               _loc13_ = "btn_go";
            }
            _loc4_[_loc8_] = new iButton(_loc13_,this,_loc5_[_loc8_] as Class,0,0);
            rc(_loc3_[_loc8_] as Sprite,_loc4_[_loc8_] as Sprite,false,true);
            _loc14_ = new customFont(20,"..",true);
            _loc14_.setWrapWidth(110);
            _loc14_.drawString(!!this.isCharAvail(_loc8_)?_loc7_[_loc8_] as String:_loc6_[_loc8_] as String);
            _loc14_.x = _loc4_[_loc8_].x - 0;
            _loc14_.y = _loc4_[_loc8_].y + 110;
            this.bg.addChild(_loc14_);
            if(this.isCharAvail(_loc8_) || _loc8_ == 3 && GameMode.thirdVehicleUnlocked)
            {
               (_loc4_[_loc8_] as Sprite).filters = [new GlowFilter(16777215,1,12,12)];
            }
            else
            {
               (_loc4_[_loc8_] as Sprite).transform.colorTransform = new ColorTransform(0.5,0.5,0.5);
               _loc15_ = new locked_key();
               (_loc4_[_loc8_] as Sprite).addChild(_loc15_);
               _loc15_.y = 40;
               _loc15_.alpha = 0.5;
            }
            _loc8_++;
         }
         var _loc9_:customFont = new customFont(18,"BLEH",false);
         rc(this.bg.infoLabel,_loc9_,false,true);
         if(GameMode.thirdVehicleUnlocked && !this.onToonGames())
         {
            _loc9_.drawHtml("\n<font color=\'#CCCCCC\'>Visit</font> <font color=\'#85BB7C\'>gamesumo.com</font> <font color=\'#ACACAC\'>to unlock</font> <font color=\'#DF694C\'>Spongebob</font>");
            makeButton(this.bg.nextButton,"btn_go");
            _loc9_.addEventListener(MouseEvent.CLICK,this.labelClick);
            _loc9_.useHandCursor = true;
         }
         else
         {
            _loc9_.drawHtml("<font size=\'22\'>\n\nHint: Press enter to reselect the last character.</font>");
            this.bg.nextButton.visible = false;
         }
         gMode.keyMenu = this;
      }
      
      public function updateScroll(param1:Number) : void
      {
      }
      
      public function labelClick(param1:Event = null) : void
      {
         this.buttonPressed("btn_go");
      }
      
      public function isCharAvail(param1:int) : Boolean
      {
         switch(param1)
         {
            case 0:
               return true;
            case 1:
               return GameMode.secondVehicleUnlocked;
            case 2:
               return GameMode.thirdVehicleUnlocked;
            case 3:
               return this.onToonGames() && GameMode.thirdVehicleUnlocked;
            default:
               return false;
         }
      }
      
      public function onToonGames() : Boolean
      {
         return global.mainStage.loaderInfo.url.toLowerCase().indexOf("gamesumo.com") > -1 || global.DK;
      }
      
      public function btn(param1:int) : iButton
      {
         return buttonSave[param1] as iButton;
      }
      
      override public function keyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER || param1.keyCode == 82)
         {
            LevelUtils.loadLevelCache();
         }
      }
      
      override public function frame(param1:Event) : void
      {
         super.frame(param1);
         this.frameCount++;
         if(this.frameCount == 2)
         {
            WipeHandler.finishSwipe();
         }
      }
      
      override public function buttonPressed(param1:String) : void
      {
         switch(param1)
         {
            case "btn_0":
               this.setChar(0);
               SoundHandler.playSoundClass(sound_clicking);
               break;
            case "btn_1":
               this.setChar(1);
               SoundHandler.playSoundClass(sound_clicking);
               break;
            case "btn_2":
               this.setChar(2);
               SoundHandler.playSoundClass(sound_clicking);
               break;
            case "btn_3":
               this.setChar(3);
               SoundHandler.playSoundClass(sound_clicking);
               break;
            case "btn_go":
               this.launchURL(global.url_pmg_charselect);
               break;
            case "btn_back":
               GameMode.gameMode.showLevelSelect();
         }
         super.buttonPressed(param1);
      }
      
      public function setChar(param1:int) : void
      {
         if(this.isCharAvail(param1))
         {
            GameMode.selectedCharacter = param1;
            LevelUtils.loadLevelCache();
         }
      }
      
      public function launchURL(param1:String) : void
      {
         gMode.launchURL(param1);
      }
      
      override public function popup() : void
      {
         super.popup();
         Menu_LevelSelect.selectActive = true;
      }
      
      public function initLevel(param1:int = 0) : void
      {
      }
   }
}
