package
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.system.System;
   import flash.ui.Keyboard;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import nape.constraint.PivotJoint;
   import nape.geom.Vec2;
   import objects.cBiped;
   import objects.cCar;
   import objects.cHitler;
   import objects.cObject;
   import objects.cPickupGun2;
   import objects.cPickupGun3;
   import objects.cPickupGun4;
   import objects.cPickupLife;
   import objects.cProjectileGun;
   
   public class GameMode extends World
   {
      
      public static var gameMode:GameMode;
      
      public static var lastLevelUnlocked:int = 0;
      
      public static var goal:Boolean = false;
      
      public static var completed:Boolean = false;
      
      public static var failed:Boolean = false;
      
      public static var finished:Boolean = false;
      
      public static var _playing:Boolean = false;
      
      public static var control:Boolean = false;
      
      public static var secondVehicleUnlocked:Boolean = false;
      
      public static var thirdVehicleUnlocked:Boolean = false;
      
      public static var selectedCharacter:int = 0;
      
      public static var totalCash:int = 0;
      
      public static var helpShown:Boolean = false;
      
      public static var rPending:int = -1;
      
      public static var mousePendingFlag:Boolean = false;
      
      public static var mouseIsDown:Boolean = false;
       
      
      public var superCleanup:Boolean = true;
      
      public var sounds:SoundHandler;
      
      public var uiHandler:UIHandler;
      
      public var spawnHandler:SpawnTable;
      
      public var lastObject:cObject;
      
      var countdown:Boolean = false;
      
      public var dragging:Boolean = false;
      
      public var m_mouseJoint:PivotJoint;
      
      public var alreadyComplete:Boolean = false;
      
      public var shiftDown:Boolean = false;
      
      public var rotLeftDown:Boolean = false;
      
      public var rotRightDown:Boolean = false;
      
      public var accelDown:Boolean = false;
      
      public var revDown:Boolean = false;
      
      public var spaceDown:Boolean = false;
      
      public var xDown:Boolean = false;
      
      public var zDown:Boolean = false;
      
      public var qDown:Boolean = false;
      
      public var eDown:Boolean = false;
      
      public var FPS:uint = 0;
      
      public var keyMenu:PopupMenu;
      
      public var engineAllowed:Boolean = false;
      
      public var dbgText:customFont;
      
      public var dbgText2:customFont;
      
      var now:Date;
      
      var cTime:uint = 0;
      
      var lTime:uint = 0;
      
      var fCount:uint = 0;
      
      public var scoreCache:Number = 0;
      
      public var tempOutAngle:Number = 0;
      
      var loadPlayerLap:int = 0;
      
      var loadPlayerLapLast:int = -1;
      
      var oneDrawn:Boolean = false;
      
      var twoDrawn:Boolean = false;
      
      var threeDrawn:Boolean = false;
      
      var fourDrawn:Boolean = false;
      
      var fiveDrawn:Boolean = false;
      
      public var gls:int = 0;
      
      public function GameMode(param1:Main, param2:SoundHandler)
      {
         this.dbgText = new customFont(20,"dbg");
         this.dbgText2 = new customFont(20,"dbg2");
         this.now = new Date();
         gameMode = this;
         super(param1);
         ScoreHandler.cleanupEverything();
         Serialiser.loadStats();
         LevelUtils.gMode = this;
         main = param1;
         this.sounds = param2;
         this.uiHandler = new UIHandler(this);
         this.spawnHandler = new SpawnTable(this);
         addChild(this.uiHandler);
         this.dbgText.x = 450;
         this.dbgText.y = 50;
         this.dbgText.visible = false;
         addChild(this.dbgText);
         this.dbgText2.x = 30;
         this.dbgText2.y = 50;
         this.dbgText2.visible = false;
         addChild(this.dbgText2);
         addEventListener(MouseEvent.CLICK,this.onMouseClick);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         addEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
         WipeHandler.beginSwipe(null);
      }
      
      public static function get playing() : Boolean
      {
         return _playing;
      }
      
      public static function set playing(param1:Boolean) : void
      {
         _playing = param1;
      }
      
      public static function formatTimeS(param1:int) : String
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(param1 > 0)
         {
            _loc2_ = Math.floor(param1 / 1000);
            _loc3_ = pad5(_loc2_.toString());
            return _loc3_;
         }
         return "00000";
      }
      
      public static function formatTimeMS(param1:int) : String
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         if(param1 > 0)
         {
            _loc2_ = Math.floor(param1 / 1000);
            _loc3_ = _loc2_ % 60;
            _loc4_ = Math.floor(_loc2_ / 60);
            _loc5_ = addZeros(_loc4_.toString()) + ":" + addZeros(_loc3_.toString());
            return _loc5_;
         }
         return "00:00";
      }
      
      public static function formatScore(param1:int) : String
      {
         var _loc2_:String = addZeros(param1.toString());
         var _loc3_:String = "";
         var _loc4_:int = 0;
         var _loc5_:int = _loc2_.length - 1;
         while(_loc5_ > -1)
         {
            _loc3_ = _loc2_.charAt(_loc5_) + _loc3_;
            _loc4_++;
            if(_loc4_ == 3 && _loc5_ != 0)
            {
               _loc3_ = "," + _loc3_;
               _loc4_ = 0;
            }
            _loc5_--;
         }
         return _loc3_;
      }
      
      public static function timerValueToString(param1:int) : String
      {
         var _loc2_:String = "";
         var _loc3_:int = param1 % 60;
         var _loc4_:int = param1 / 60;
         var _loc5_:String = _loc3_.toString();
         var _loc6_:String = _loc4_.toString();
         if(_loc5_.length < 2)
         {
            _loc5_ = "0" + _loc5_;
         }
         if(_loc6_.length < 2)
         {
            _loc6_ = "0" + _loc6_;
         }
         _loc2_ = _loc6_ + ":" + _loc5_;
         return _loc2_;
      }
      
      public static function addZeros(param1:String) : *
      {
         var _loc2_:String = param1;
         while(_loc2_.length < 2)
         {
            _loc2_ = "0" + _loc2_;
         }
         return _loc2_;
      }
      
      public static function pad3(param1:String) : *
      {
         var _loc2_:String = param1;
         while(_loc2_.length < 3)
         {
            _loc2_ = "0" + _loc2_;
         }
         return _loc2_;
      }
      
      public static function pad5(param1:String) : *
      {
         var _loc2_:String = param1;
         while(_loc2_.length < 5)
         {
            _loc2_ = "0" + _loc2_;
         }
         return _loc2_;
      }
      
      public static function pad8(param1:String) : *
      {
         var _loc2_:String = param1;
         while(_loc2_.length < 8)
         {
            _loc2_ = "0" + _loc2_;
         }
         return _loc2_;
      }
      
      public static function ensureLength(param1:String) : String
      {
         var _loc3_:String = null;
         var _loc4_:* = null;
         var _loc2_:* = "";
         if(param1.indexOf(".") == -1)
         {
            _loc2_ = param1 + ".0";
         }
         else
         {
            _loc3_ = param1.split(".")[0];
            _loc4_ = param1.split(".")[1];
            while(_loc4_.length < 1)
            {
               _loc4_ = _loc4_ + "0";
            }
            while(_loc4_.length > 1)
            {
               _loc4_ = _loc4_.substring(0,1);
            }
            _loc2_ = _loc3_ + "." + _loc4_;
         }
         return _loc2_;
      }
      
      public static function recreateCarGraphics() : void
      {
         if(World.followObj != null)
         {
            (World.followObj as cCar).setGraphics();
         }
      }
      
      public static function getClass(param1:Object) : Class
      {
         return Class(getDefinitionByName(getQualifiedClassName(param1)));
      }
      
      public static function imageFromIndex(param1:int, param2:int) : Sprite
      {
         return new customFont(22,"imageFromIndex");
      }
      
      public function editLevel() : *
      {
         if(!World.currentLevel.inEditor)
         {
            if(!World.currentLevel.inEditorPreview)
            {
               Level.editString = currentLevel.levelString;
            }
            LevelUtils.re_initLevel(World.currentLevel.myID,Level.MODE_EDITOR);
         }
         else if(World.currentLevel.inEditor)
         {
            Level.editString = LevelUtils.generateObjectString();
            LevelUtils.initLevel(World.currentLevel.myID,Level.MODE_PREVIEW);
         }
      }
      
      public function buttonPressed(param1:String) : void
      {
         switch(param1)
         {
            case global.pmg_button_command_ingame:
               this.launchURL(global.url_pmg_ingame);
               break;
            case global.pmg_button_command_regular:
               this.launchURL(global.url_pmg_regular);
               break;
            case global.pmg_button_command_loading:
               this.launchURL(global.url_pmg_loading);
               break;
            case global.pmg_button_command_menu:
               this.launchURL(global.url_pmg_menu);
               break;
            case global.pmg_button_command_charselect:
               this.launchURL(global.url_pmg_charselect);
               break;
            case "btn_fgfys":
               this.launchURL(global.url_fgfsy);
               break;
            case "btn_highscores":
               MochiConnect.staticSelf.showScores(0);
         }
         if(param1 == "btn_sponsor")
         {
            if(World.currentLevel != null && World.currentLevel.myID >= Level.LEVEL_1)
            {
               this.launchURL(global.url_pmg_ingame);
            }
            else
            {
               this.launchURL(global.url_pmg_menu);
            }
         }
      }
      
      public function launchURL(param1:String) : void
      {
         main.launchURL(param1);
      }
      
      public function slide(param1:String) : *
      {
         SliderHandler.addSlider(param1);
      }
      
      public function newGame() : *
      {
         ScoreHandler.cleanupEverything();
         Serialiser.loadStats();
         PopupHandler.clearMenus();
         this.showIntroMenu();
         SlugScore.newGame();
      }
      
      public function submitScore(param1:Number = 0) : void
      {
         this.scoreCache = param1;
      }
      
      public function submitScoreCache() : void
      {
         var _loc1_:Number = NaN;
         if(GameMode.gameMode.scoreCache > 0)
         {
            _loc1_ = GameMode.gameMode.scoreCache;
            GameMode.gameMode.scoreCache = 0;
            MochiConnect.staticSelf.submitScore(_loc1_);
         }
      }
      
      public function ensureClearLevel(param1:int = 0) : void
      {
         if(currentLevel != null && currentLevel.myID != param1 || currentLevel == null)
         {
            LevelUtils.initLevel(param1);
         }
      }
      
      public function showIntroMenu() : void
      {
         this.ensureClearLevel(Level.LEVEL_INTRO);
         PopupHandler.clearMenus();
         var _loc1_:Menu_Intro = new Menu_Intro(this,PopupHandler.self);
         PopupHandler.popupAsMenu(_loc1_);
      }
      
      public function showLevelPassed() : void
      {
         this.sounds.stopEngine();
         PopupHandler.clearMenus();
         this.saveLastLevel();
         var _loc1_:Menu_LevelPassed = new Menu_LevelPassed(this,PopupHandler.self);
         PopupHandler.popupAsMenu(_loc1_);
      }
      
      public function saveLastLevel() : *
      {
         if(World.currentLevel.myID >= Level.LEVEL_1)
         {
            GameMode.lastLevelUnlocked = World.currentLevel.myID;
         }
         TTSettings.stat_totalDistance = TTSettings.stat_totalDistance + World.currentLevel.currentDistance;
         TTSettings.stat_totalCash = TTSettings.stat_totalCash + ScoreHandler.calculateLevelScore();
         Serialiser.saveStats();
      }
      
      public function showGamePassed() : void
      {
         PopupHandler.clearMenus();
         var _loc1_:Menu_GamePassed = new Menu_GamePassed(this,PopupHandler.self);
         PopupHandler.popupAsMenu(_loc1_);
      }
      
      public function showHelp(param1:int = 0) : void
      {
         PopupHandler.clearMenus();
         var _loc2_:Menu_LevelSelect = new Menu_LevelSelect(this,PopupHandler.self);
         PopupHandler.popupAsMenu(_loc2_);
      }
      
      public function showCharSelect() : void
      {
         PopupHandler.clearMenus();
         var _loc1_:Menu_CharSelect = new Menu_CharSelect(this,PopupHandler.self);
         PopupHandler.popupAsMenu(_loc1_);
      }
      
      public function showLevelSelect() : void
      {
         this.ensureClearLevel(0);
         PopupHandler.clearMenus();
         var _loc1_:Menu_LevelSelect = new Menu_LevelSelect(this,PopupHandler.self);
         PopupHandler.popupAsMenu(_loc1_);
      }
      
      public function showLoadingScreen() : void
      {
         PopupHandler.clearMenus();
         var _loc1_:Menu_Loading = new Menu_Loading(this,PopupHandler.self);
         PopupHandler.popupAsMenu(_loc1_);
      }
      
      public function showLevelFailed(param1:Boolean = false) : void
      {
         this.sounds.stopEngine();
         var _loc2_:Menu_LevelFailed = new Menu_LevelFailed(this,PopupHandler.self,param1);
         PopupHandler.popupAsMenu(_loc2_);
      }
      
      public function showReset() : void
      {
         var _loc1_:YesNoPopup = new YesNoPopup("Title",this,PopupHandler.self,this.resetting,this.resetting,"Content","OptA","OptB",true,false);
         _loc1_.exclusive = false;
         PopupHandler.popupAsMenu(_loc1_);
      }
      
      public function resetting(param1:Boolean) : *
      {
         if(!param1)
         {
         }
         this.showIntroMenu();
      }
      
      public function wannaSeeShop() : void
      {
         PopupHandler.clearMenus();
      }
      
      public function cleanup() : void
      {
         UIHandler.unPause();
         World.stopTicking = false;
         this.gls = 0;
         EffectIndicator.self.cleanup();
         System.gc();
         Camera.setScale(1,true);
         Camera.bossLocked = false;
         Camera.followX = 0;
         Camera.followY = 0;
         Camera.targX = 0;
         Camera.targY = 0;
         this.clearDrawnSections();
         following = true;
         this.carCleanup();
         this.uiHandler.cleanup();
         followObj = null;
         failed = false;
         finished = false;
         completed = false;
         goal = false;
         frameCount = 0;
         this.alreadyComplete = false;
         this.lastObject = null;
         cObject.camera_offset_car_x = cObject.camera_offset_car_x_default;
         cObject.camera_offset_car_x_targ = cObject.camera_offset_car_x_default;
         StatusHandler.statusTopLeft = " ";
         StatusHandler.statusMiddle = " ";
         StatusHandler.statusTopRight = " ";
         while(m_world.constraints.length > 0)
         {
            EntUtils.destroyJoint(m_world.constraints.at(0));
         }
         PopupHandler.clearMenus();
         QueryHandler.clearMarkedBodies();
         while(m_world.bodies.length > 0)
         {
            EntUtils.destroyBody(m_world.bodies.at(0) as Boner);
         }
         removeBulletTime();
         removeClamped();
         removeIcyRoad();
         removeInvulnerability();
         removeLowGrav();
         EffectIndicator.self.removeAllStatuses();
         LevelUtils.destroyObjects();
         ScoreHandler.cleanup();
      }
      
      public function carCleanup() : *
      {
         this.rotLeftDown = false;
         this.rotRightDown = false;
         this.accelDown = false;
         this.revDown = false;
         this.spaceDown = false;
         this.qDown = false;
         this.eDown = false;
         this.sounds.stopEngine();
         GroundUtils.streamingFixtureList = [];
      }
      
      override public function Update(param1:Event) : void
      {
         if(!worldLocked)
         {
            control = !UIHandler.paused && playing && !failed && !completed && !this.countdown && this.keyMenu == null && !World.currentLevel.inEditor && World.currentLevel.controlable && !PopupHandler.menuActive();
            if(followObj != null && followObj.bodyParts.length < 1)
            {
               followObj = null;
            }
            this.handleDragging();
            this.isEngineAllowed();
            this.gameLogic();
            if(frameCount % 30 == 0 || frameCount == 2)
            {
               GroundUtils.checkStreamingGround();
            }
            LevelUtils.updateObjects();
            this.FPSMeter();
            this.uiHandler.frame();
            if(frameCount == 2 && WipeHandler.activeSwipe != null)
            {
               WipeHandler.finishSwipe();
            }
            frameCount++;
            if(Migrate.stopMusic)
            {
               Migrate.stopMusic = false;
               this.sounds.stopMusic();
            }
            if(Migrate.beginMusic)
            {
               Migrate.beginMusic = false;
               this.sounds.playMusic();
            }
            if(Migrate.bulletPending)
            {
               Migrate.bulletPending = false;
               SoundHandler.playSoundClass(sound_woodbreak);
               SoundHandler.playSoundClass(sound_asplosion);
            }
            if(Migrate.soundPending)
            {
               Migrate.soundPending = false;
               SoundHandler.playSoundClass(sound_bang);
            }
            super.Update(param1);
            if(rPending > -1)
            {
               if(followObj != null)
               {
                  rPending--;
                  if(rPending > -1)
                  {
                     LevelUtils.re_initLevel(World.currentLevel.myID);
                     followObj.slugCast.slug_lives = rPending;
                  }
                  else
                  {
                     this.showLevelFailed();
                  }
               }
               else
               {
                  this.showLevelFailed();
               }
            }
            rPending = -1;
         }
         else
         {
            if(frameCount % 80 == 0)
            {
            }
            if(World.currentLevel.staggeredLoading && !World.currentLevel.staggeredLoadingComplete && World.currentLevel.staggeredLoadingStarted)
            {
               if(World.currentLevel.staggeredLoadingBlock >= Level.slMax)
               {
                  World.currentLevel.staggeredLoadingComplete = true;
                  if(helpShown)
                  {
                     this.finishStaggeredLoading();
                  }
               }
            }
         }
         if(LevelUtils.reloadPending)
         {
            LevelUtils.initLevel(World.currentLevel.myID);
         }
      }
      
      public function finishStaggeredLoading() : *
      {
         throw new Error("Make sure this bit works...");
      }
      
      public function isEngineAllowed() : Boolean
      {
         this.engineAllowed = false;
         if(followObj != null && !completed && !failed && World.currentLevel.controlable)
         {
            this.engineAllowed = true;
         }
         return this.engineAllowed;
      }
      
      public function gameLogic() : *
      {
         if(World.currentLevel != null)
         {
            StatusHandler.statusTopLeft = "Level " + (Level.getLevelIndex() + 1).toString();
            if(World.currentLevel.controlable)
            {
               StatusHandler.statusMiddle = formatTimeS(ScoreHandler.bonusTimeLeft);
            }
            StatusHandler.statusTopRight = pad8(ScoreHandler.catchupScore.toString());
         }
         if(!completed && !finished && playing && !World.currentLevel.inEditorOrPreview && !this.countdown && World.currentLevel.controlable && followObj != null)
         {
            this.challengeHandler();
         }
         if(World.currentLevel != null && World.currentLevel.respawnTimer > -1)
         {
            if(World.currentLevel.respawnTimer == 0)
            {
               LevelUtils.restoreObj(followObj);
            }
            World.currentLevel.respawnTimer = World.currentLevel.respawnTimer - 1;
            World.currentLevel.controlable = true;
         }
         else if(World.currentLevel == null)
         {
         }
      }
      
      public function challengeHandler() : void
      {
         ScoreHandler.tick();
         if(!goal && !failed)
         {
            if(followObj.currentX > 2800 * SpriteUtils.groundClips.length / World.gameScale - 200)
            {
               goal = true;
            }
         }
         else
         {
            currentLevel.useSystemTime = false;
            if(goal && !completed)
            {
               following = false;
               completed = true;
               ScoreHandler.levelPassed();
               Serialiser.saveStats();
               this.showLevelPassed();
            }
            if(failed && !finished)
            {
               finished = true;
               this.showLevelFailed(false);
            }
         }
      }
      
      public function calcDistance(param1:Boner, param2:Boner) : Number
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc3_:Number = 6666;
         if(param1 != null && param2 != null)
         {
            _loc4_ = param1.position.x;
            _loc5_ = param1.position.y;
            _loc6_ = param2.position.x;
            _loc7_ = param2.position.y;
            _loc3_ = Math.sqrt(Math.pow(_loc6_ - _loc4_,2) + Math.pow(_loc7_ - _loc5_,2));
         }
         return _loc3_;
      }
      
      public function collection2(param1:String, param2:int) : *
      {
         if(control && !completed && !goal && !failed)
         {
            CollectionHandler.addCollection(param1,param2);
         }
      }
      
      public function makeFade(param1:String, param2:int, param3:Boolean = false) : *
      {
         FadeHandler.makeFade(param1,param2,param3);
      }
      
      public function escapePressed() : void
      {
         this.ensureClearLevel(Level.LEVEL_INTRO);
         this.showIntroMenu();
      }
      
      public function onKeyboardDown(param1:KeyboardEvent) : void
      {
         var _loc3_:customFont = null;
         if(!PopupHandler.menuActive())
         {
            if(param1.keyCode == Keyboard.ENTER || param1.keyCode == 82)
            {
               if(currentLevel.inEditorOrPreview)
               {
                  this.editLevel();
               }
               else if(!goal)
               {
                  LevelUtils.initLevel(currentLevel.myID);
               }
            }
            if(param1.keyCode == Keyboard.ESCAPE)
            {
               this.escapePressed();
            }
         }
         else if(this.keyMenu != null)
         {
            this.keyMenu.keyDown(param1);
         }
         if(param1.keyCode == Keyboard.SPACE)
         {
            this.spaceDown = true;
         }
         if(param1.keyCode == Keyboard.Q)
         {
            this.qDown = true;
         }
         if(param1.keyCode == Keyboard.E)
         {
            this.eDown = true;
         }
         if(param1.keyCode == Keyboard.UP)
         {
            this.accelDown = true;
         }
         if(param1.keyCode == Keyboard.DOWN)
         {
            this.revDown = true;
         }
         if(param1.keyCode == Keyboard.LEFT)
         {
            this.rotLeftDown = true;
         }
         if(param1.keyCode == Keyboard.RIGHT)
         {
            this.rotRightDown = true;
         }
         if(param1.keyCode == Keyboard.W)
         {
            this.accelDown = true;
         }
         if(param1.keyCode == Keyboard.S)
         {
            this.revDown = true;
         }
         if(param1.keyCode == Keyboard.A)
         {
            this.rotLeftDown = true;
         }
         if(param1.keyCode == Keyboard.D)
         {
            this.rotRightDown = true;
         }
         if(param1.keyCode == Keyboard.NUMBER_1)
         {
            this.trySetWeap(cProjectileGun.TYPE_PISTOL);
         }
         if(param1.keyCode == Keyboard.NUMBER_2)
         {
            this.trySetWeap(cProjectileGun.TYPE_MACHINEGUN);
         }
         if(param1.keyCode == Keyboard.NUMBER_3)
         {
            this.trySetWeap(cProjectileGun.TYPE_SHOTGUN);
         }
         if(param1.keyCode == Keyboard.NUMBER_4)
         {
            this.trySetWeap(cProjectileGun.TYPE_SHOTGUN);
         }
         if(param1.keyCode == 88)
         {
            this.xDown = true;
         }
         if(param1.keyCode == 90)
         {
            this.zDown = true;
         }
         if(param1.keyCode == Keyboard.NUMPAD_1)
         {
            LevelUtils.rotate(true);
         }
         if(param1.keyCode == Keyboard.NUMPAD_3)
         {
            LevelUtils.rotate(false);
         }
         if(param1.keyCode == Keyboard.NUMPAD_4)
         {
            LevelUtils.objectChange(false);
         }
         if(param1.keyCode == Keyboard.NUMPAD_5)
         {
            LevelUtils.objectChange(true);
         }
         if(followObj != null && (followObj as cCar).myHandler != null)
         {
         }
         if(param1.keyCode == Keyboard.SHIFT)
         {
            this.shiftDown = true;
         }
         if(param1.keyCode == 221)
         {
            Camera.addScale(0.2);
         }
         if(param1.keyCode == 219)
         {
            Camera.addScale(-0.2);
         }
         if(this.shiftDown)
         {
            if(param1.keyCode == Keyboard.F2)
            {
               _loc3_ = new customFont(20,"RC1 - 20_12_12 - 14:59 ish",false);
               _loc3_.x = 50;
               _loc3_.y = 50;
               UIHandler.self.addChild(_loc3_);
            }
         }
         if(this.shiftDown && param1.keyCode == Keyboard.F5)
         {
         }
         if(this.shiftDown && global.DK)
         {
            if(param1.keyCode == Keyboard.F2)
            {
               this.dbgText.visible = !this.dbgText.visible;
               this.dbgText2.visible = false;
            }
            if(param1.keyCode == Keyboard.F3)
            {
               DebugMenu.self.visible = !DebugMenu.self.visible;
            }
            if(param1.keyCode == Keyboard.F6)
            {
               this.editLevel();
            }
            if(param1.keyCode == Keyboard.F5)
            {
               World.drawDebugShapes = false;
            }
            if(param1.keyCode == Keyboard.F7)
            {
               LevelUtils.levelOb(new cHitler(followObj.currentX + 190,100,this,0));
            }
            if(param1.keyCode == Keyboard.F8)
            {
            }
            if(param1.keyCode == Keyboard.F9)
            {
               LevelUtils.levelOb(new cPickupGun2(followObj.currentX + 50,100,this,180));
               LevelUtils.levelOb(new cPickupGun3(followObj.currentX + 90,100,this,180));
               LevelUtils.levelOb(new cPickupGun4(followObj.currentX + 130,100,this,180));
               LevelUtils.levelOb(new cPickupLife(followObj.currentX + 170,100,this,180));
            }
         }
         if(World.currentLevel.inEditor)
         {
            if(this.accelDown)
            {
               Camera.targY = Camera.targY - 100;
            }
            if(this.revDown)
            {
               Camera.targY = Camera.targY + 100;
            }
            if(this.rotRightDown)
            {
               Camera.targX = Camera.targX + 100;
            }
            if(this.rotLeftDown)
            {
               Camera.targX = Camera.targX - 100;
            }
            if(!this.revDown)
            {
            }
         }
      }
      
      public function trySetWeap(param1:int) : *
      {
         if(World.followObj != null && !goal && !failed && control)
         {
            (World.followObj as cBiped).setWeapon(param1);
         }
      }
      
      public function inDebugMode() : Boolean
      {
         var traceCheck:Function = function():String
         {
            returnValue = true;
            return "Debug check returned true. Yay!";
         };
         var returnValue:Boolean = false;
         return returnValue;
      }
      
      public function mouseOut(param1:MouseEvent) : void
      {
         if(World.currentLevel != null && !World.currentLevel.inEditor)
         {
            this.shiftDown = false;
            this.accelDown = false;
            this.rotLeftDown = false;
            this.rotRightDown = false;
            this.accelDown = false;
            this.revDown = false;
            this.rotRightDown = false;
            this.rotLeftDown = false;
            this.qDown = false;
            this.eDown = false;
            this.spaceDown = false;
            this.xDown = false;
            this.zDown = false;
         }
      }
      
      public function onKeyboardUp(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.SHIFT)
         {
            this.shiftDown = false;
         }
         if(param1.keyCode == Keyboard.UP)
         {
            this.accelDown = false;
         }
         if(param1.keyCode == Keyboard.DOWN)
         {
            this.revDown = false;
         }
         if(param1.keyCode == Keyboard.LEFT)
         {
            this.rotLeftDown = false;
         }
         if(param1.keyCode == Keyboard.RIGHT)
         {
            this.rotRightDown = false;
         }
         if(param1.keyCode == Keyboard.W)
         {
            this.accelDown = false;
         }
         if(param1.keyCode == Keyboard.S)
         {
            this.revDown = false;
         }
         if(param1.keyCode == Keyboard.A)
         {
            this.rotLeftDown = false;
         }
         if(param1.keyCode == Keyboard.D)
         {
            this.rotRightDown = false;
         }
         if(param1.keyCode == Keyboard.Q)
         {
            this.qDown = false;
         }
         if(param1.keyCode == Keyboard.E)
         {
            this.eDown = false;
         }
         if(param1.keyCode == Keyboard.SPACE)
         {
            this.spaceDown = false;
         }
         if(param1.keyCode == 88)
         {
            this.xDown = false;
         }
         if(param1.keyCode == 90)
         {
            this.zDown = false;
         }
      }
      
      public function playPressed() : Boolean
      {
         if(followObj != null)
         {
            Camera.setFollowing(true);
         }
         playing = true;
         goal = false;
         failed = false;
         completed = false;
         World.currentLevel.setupTimer();
         if(World.currentLevel.streamingGround)
         {
            GroundUtils.checkStreamingGround();
         }
         Menu_LevelSelect.selectActive = false;
         return true;
      }
      
      public function FPSMeter() : *
      {
         this.now = new Date();
         this.cTime = this.now.getTime();
         if(this.cTime >= this.lTime + 1000)
         {
            this.FPS = this.fCount;
            this.fCount = 0;
            this.lTime = this.cTime;
         }
         else
         {
            this.fCount++;
         }
      }
      
      public function createSpawnList() : void
      {
      }
      
      public function clearDrawnSections(param1:Boolean = false) : void
      {
         if(!param1)
         {
            this.oneDrawn = false;
         }
         this.twoDrawn = false;
         this.threeDrawn = false;
         this.fourDrawn = false;
         this.fiveDrawn = false;
      }
      
      public function loadSectional(param1:int) : void
      {
         this.loadPlayerLap = followObj.laps;
         if(this.loadPlayerLap != this.loadPlayerLapLast)
         {
            this.createSpawnList();
         }
         this.spawnHandler.spawnRandom(this,param1);
         this.loadPlayerLapLast = this.loadPlayerLap;
      }
      
      override public function loadStuff() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(World.currentLevel.loadRandomObjects)
         {
            _loc1_ = GroundUtils.currentBlock % 20;
            _loc2_ = GroundUtils.carSection;
            switch(_loc2_)
            {
               case 3:
                  this.oneDrawn = false;
                  break;
               case 4:
                  this.twoDrawn = false;
                  break;
               case 5:
                  this.threeDrawn = false;
                  break;
               case 1:
                  this.fourDrawn = false;
                  break;
               case 2:
                  this.fiveDrawn = false;
            }
            if(_loc2_ != this.gls)
            {
            }
            if(_loc2_ == 1 && (this.gls == 0 || this.gls == 5) && !this.twoDrawn)
            {
               this.loadSectional(2);
            }
            if(_loc2_ == 2 && this.gls == 1 && !this.threeDrawn)
            {
               this.loadSectional(3);
            }
            if(_loc2_ == 3 && this.gls == 2 && !this.fourDrawn)
            {
               this.loadSectional(4);
            }
            if(_loc2_ == 4 && this.gls == 3 && !this.fiveDrawn)
            {
               this.loadSectional(5);
            }
            if(_loc2_ >= 5 && this.gls == 4 && !this.oneDrawn)
            {
               this.loadSectional(1);
            }
            this.gls = _loc2_;
         }
      }
      
      public function mouseJoin(param1:Boner) : *
      {
         var _loc2_:PivotJoint = new PivotJoint(m_world.world,param1,new Vec2(),new Vec2());
         _loc2_.active = true;
         _loc2_.stiff = true;
         _loc2_.space = m_world;
         _loc2_.anchor2 = param1.worldToLocal(param1.position);
         _loc2_.maxForce = 100000;
         this.m_mouseJoint = _loc2_;
      }
      
      public function onMouseDown(param1:MouseEvent) : void
      {
         mouseIsDown = true;
         mousePendingFlag = true;
         if(dragBody != null)
         {
            this.stopDragging();
         }
         var _loc2_:Boner = QueryHandler.getBodyAtMouse(true);
         if(_loc2_ != null)
         {
            if(World.currentLevel.inEditor || global.DK)
            {
               this.startDragging(_loc2_);
            }
            else if(_loc2_.userData.owner != null)
            {
            }
         }
         else
         {
            §§push(Boolean(World.currentLevel.inEditorOrPreview));
         }
      }
      
      public function handleDragging() : void
      {
         var _loc1_:Vec2 = null;
         if(World.currentLevel.myMode == Level.MODE_EDITOR)
         {
         }
         if(playing && this.dragging)
         {
            this.stopDragging();
         }
         if(this.dragging && this.m_mouseJoint != null)
         {
            _loc1_ = new Vec2(Camera.mouseTransX - dragBody.position.x,Camera.mouseTransY - dragBody.position.y);
            (dragBody.userData.owner as cObject).translateMe(_loc1_.x,_loc1_.y);
            this.m_mouseJoint.anchor1.setxy(Camera.mouseTransX,Camera.mouseTransY);
            dragBody.userData.owner.dragging();
         }
         else
         {
            this.stopDragging();
         }
      }
      
      public function startDragging(param1:Boner) : Boolean
      {
         if(param1 != null)
         {
            if(!playing)
            {
            }
            if(param1.userData.owner != null)
            {
            }
            if(param1.userData.owner != null && (param1.userData.owner.editorDraggable || World.currentLevel.inEditor) && !playing)
            {
               dragBody = param1;
               this.dragging = true;
               this.lastObject = dragBody.userData.owner;
               dragBody.userData.owner.setLastPos();
               dragBody.userData.owner.unhookSolid();
               this.mouseJoin(dragBody);
               dragBody.userData.owner.setSensor();
               dragBody.userData.owner.unfreeze();
               dragBody.userData.owner.makeDynamic();
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function onMouseUp(param1:MouseEvent) : void
      {
         mouseIsDown = false;
         this.stopDragging();
      }
      
      public function stopDragging() : *
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:cObject = null;
         _loc3_ = null;
         _loc1_ = -1;
         _loc2_ = "";
         if(this.m_mouseJoint != null)
         {
            EntUtils.destroyJoint(this.m_mouseJoint);
            this.m_mouseJoint = null;
         }
         if(dragBody != null)
         {
            if(dragBody.userData.owner != null)
            {
               dragBody.userData.owner.freeze();
               this.lastObject = dragBody.userData.owner;
               LevelUtils.restoreObj(dragBody.userData.owner,null);
            }
         }
         dragBody = null;
         this.dragging = false;
      }
      
      public function onMouseClick(param1:MouseEvent) : void
      {
      }
   }
}
