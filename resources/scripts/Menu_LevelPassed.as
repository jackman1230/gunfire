package
{
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   import objects.cCar;
   
   public class Menu_LevelPassed extends PopupMenu
   {
       
      
      public var popupHandler:PopupHandler;
      
      public var frameCount:int = 0;
      
      var sf:level_pass_count;
      
      var gob:slug_go_back;
      
      public var fc:int = 0;
      
      public var fci:int = 0;
      
      public function Menu_LevelPassed(param1:GameMode, param2:PopupHandler)
      {
         gMode = param1;
         this.popupHandler = param2;
         hasClickGuard = false;
         super();
         SlugScore.lastLives = (World.followObj as cCar).slug_lives;
         EffectIndicator.self.removeAllStatuses();
         var _loc3_:menuBG_LevelPassed = new menuBG_LevelPassed();
         addChild(_loc3_);
         zoomChild = _loc3_;
         if(titleFont)
         {
            titleFont.visible = false;
         }
         this.sf = new level_pass_count();
         this.sf.gotoAndStop(91);
         this.sf.x = 0 - this.sf.width / 2;
         this.sf.y = 0 - this.sf.height / 2;
         zoomChild.addChild(this.sf);
         var _loc4_:String = GameMode.formatTimeMS(ScoreHandler.bonusTimeLeft);
         var _loc5_:String = ScoreHandler.coinsCollected.toString();
         var _loc6_:int = ScoreHandler.bonusTimeLeftBonus / 1000 * 1000;
         var _loc7_:int = ScoreHandler.coinsCollected * 100;
         var _loc8_:String = GameMode.formatScore(ScoreHandler.calculateTotalScore(false));
         var _loc12_:* = "<font size = \'22\' > Time Left: <font color=\'#CCDDFF\'>" + _loc4_ + "</font></font><br>" + "<font size = \'18\' > &nbsp;&nbsp; Bonus: <font color=\'#CCDDFF\'>" + _loc6_.toString() + "</font></font><br><br>" + "<font size = \'22\' > Presents: <font color=\'#CCDDFF\'>" + _loc5_ + "</font></font><br>" + "<font size = \'18\' > &nbsp;&nbsp; Bonus: <font color=\'#CCDDFF\'>" + _loc7_.toString() + "</font></font><br><br>" + "<font size = \'28\' > Total: <font color=\'#CCFFFF\'>" + _loc8_.toString() + "</font></font>";
         this.sf.showpad.totaltext.htmlText = "Total: " + GameMode.formatScore(ScoreHandler.calculateTotalScore(true)) + " ";
         this.sf.showpad.btn01.addEventListener(MouseEvent.CLICK,this.clickieNew);
         this.sf.showpad.btn02.addEventListener(MouseEvent.CLICK,this.clickieNew2);
         gMode.keyMenu = this;
         SoundHandler.playSoundClass(sound_pickup_life);
      }
      
      public function clickieNew(param1:Event = null) : void
      {
         if(World.currentLevel.myID == Level.LEVEL_7)
         {
            this.gob = new slug_go_back();
            this.gob.btn01.addEventListener(MouseEvent.MOUSE_UP,this.clickyTwo);
            addChild(this.gob);
         }
         else
         {
            this.clickyTwo(param1);
         }
      }
      
      public function clickyTwo(param1:Event = null) : void
      {
         this.buttonPressed("btn_continue");
      }
      
      public function clickieNew2(param1:Event = null) : void
      {
         this.buttonPressed(global.pmg_button_command_menu);
      }
      
      public function redrawDetails() : void
      {
         var _loc4_:String = null;
         var _loc1_:int = ScoreHandler.bonusTimeLeftBonus / 1000 * 1000;
         var _loc2_:int = ScoreHandler.coinBonus;
         var _loc3_:int = ScoreHandler.calculateLevelScore();
         if(this.fci == 1)
         {
            _loc4_ = "Kill Bonus:" + "<br><font size=\'40\'>" + _loc2_.toString() + "</font>";
         }
         else if(this.fci == 2)
         {
            _loc4_ = "Level Total:" + "<br><font size=\'40\'>" + _loc3_.toString() + "</font>";
         }
         else
         {
            _loc4_ = "Time Bonus:" + "<br><font size=\'40\'>" + _loc1_.toString() + "</font>";
         }
         this.sf.showpad.timetext.htmlText = _loc4_;
         this.sf.showpad.timetext.scaleX = 0.4;
         this.sf.showpad.timetext.scaleY = 0.4;
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
         super.buttonPressed(param1);
         switch(param1)
         {
            case "btn_continue":
               this.continuePressed();
               break;
            case "btn_submit":
               GameMode.gameMode.submitScore(ScoreHandler.systemTimePassed);
         }
      }
      
      override public function frame(param1:Event) : void
      {
         super.frame(param1);
         if(direction == DIRECTION_FULLY_UP)
         {
            GameMode.gameMode.submitScoreCache();
            if(this.fc % 50 == 0)
            {
               this.redrawDetails();
               this.fci++;
               if(this.fci > 2)
               {
                  this.fci = 0;
               }
            }
            this.fc++;
            if(this.sf.showpad.timetext.scaleX < 1)
            {
               this.sf.showpad.timetext.scaleX = this.sf.showpad.timetext.scaleX * 1.4;
               this.sf.showpad.timetext.scaleY = this.sf.showpad.timetext.scaleY * 1.4;
               if(this.sf.showpad.timetext.scaleX > 1)
               {
                  this.sf.showpad.timetext.scaleX = 1;
                  this.sf.showpad.timetext.scaleY = 1;
                  SoundHandler.playSoundClass(sound_clicking);
               }
            }
         }
      }
      
      public function continuePressed() : void
      {
         if(World.currentLevel.myID - Level.LEVEL_1 + 1 == Level.numPlayableLevels)
         {
            GameMode.gameMode.showGamePassed();
         }
         else
         {
            LevelUtils.initLevel(World.currentLevel.myID + 1);
         }
      }
   }
}
