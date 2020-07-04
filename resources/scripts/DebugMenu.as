package
{
   import flash.display.Sprite;
   import objects.cCarryable;
   
   public class DebugMenu extends Sprite
   {
      
      public static var self:DebugMenu;
       
      
      public var myParent:Sprite;
      
      public var xGrid:Number = 180;
      
      public var yGrid:Number = 50;
      
      public var xs:Number = 0;
      
      public var ys:Number = 0;
      
      public function DebugMenu(param1:Sprite)
      {
         super();
         this.myParent = param1;
         self = this;
         this.myParent.addChild(this);
         this.addStuff();
         scaleX = 0.5;
         scaleY = 0.5;
         visible = false;
      }
      
      public function addStuff() : void
      {
         addChild(new customFont(20,"Bubble!",false));
         this.addB("m_close");
         this.addB("m_stats");
         this.addB("m_intro");
         this.addB("m_help");
         this.addB("m_levelselect");
         this.addB("m_levelcomplete");
         this.addB("m_levelfailed");
         this.addB("m_levelfailed2");
         this.addB("m_gamecomplete");
         this.addB("v_goal");
         this.addB("v_failed");
         this.addB("v_debugging");
         this.addB("l_level1");
         this.addB("l_level2");
         this.addB("l_level3");
         this.addB("l_level4");
         this.addB("l_level5");
         this.addB("l_level6");
         this.addB("l_level7");
         this.addB("l_level8");
         this.addB("l_level9");
         this.addB("l_level10");
         this.addB("l_level11");
         this.addB("l_level12");
         this.addB("wipe");
         this.addB("SS_0");
         this.addB("SS_1");
         this.addB("SS_2");
         this.addB("SS_3");
         this.addB("SS_4");
         this.addB("SE_0");
         this.addB("SE_1");
         this.addB("SE_2");
         this.addB("SE_3");
         this.addB("SE_4");
         this.addB("DK_toggle");
         this.addB("score");
      }
      
      public function buttonPressed(param1:String) : void
      {
         switch(param1)
         {
            default:
               break;
            case "m_close":
               visible = false;
               break;
            case "m_stats":
               GameMode.gameMode.dbgText.visible = !GameMode.gameMode.dbgText.visible;
               break;
            case "m_intro":
               GameMode.gameMode.showIntroMenu();
               break;
            case "m_help":
               GameMode.gameMode.showHelp();
               break;
            case "m_levelselect":
               GameMode.gameMode.showLevelSelect();
               break;
            case "m_levelcomplete":
               GameMode.gameMode.showLevelPassed();
               break;
            case "m_levelfailed":
               GameMode.gameMode.showLevelFailed(false);
               break;
            case "m_levelfailed2":
               GameMode.gameMode.showLevelFailed(true);
               break;
            case "m_gamecomplete":
               GameMode.gameMode.showGamePassed();
               break;
            case "v_goal":
               GameMode.goal = true;
               break;
            case "v_failed":
               GameMode.failed = true;
               break;
            case "v_debugging":
               World.debugging = !World.debugging;
               break;
            case "s_block":
               LevelUtils.levelOb(new cCarryable(World.followObj.currentX - 4 + Math.random() * 2,World.followObj.currentY - 8.5,GameMode.gameMode,0));
               break;
            case "l_level1":
               LevelUtils.initLevel(Level.LEVEL_1);
               break;
            case "l_level2":
               LevelUtils.initLevel(Level.LEVEL_2);
               break;
            case "l_level3":
               LevelUtils.initLevel(Level.LEVEL_3);
               break;
            case "l_level4":
               LevelUtils.initLevel(Level.LEVEL_4);
               break;
            case "l_level5":
               LevelUtils.initLevel(Level.LEVEL_5);
               break;
            case "l_level6":
               LevelUtils.initLevel(Level.LEVEL_6);
               break;
            case "l_level7":
               LevelUtils.initLevel(Level.LEVEL_7);
               break;
            case "l_level8":
               LevelUtils.initLevel(Level.LEVEL_8);
               break;
            case "l_level9":
               LevelUtils.initLevel(Level.LEVEL_9);
               break;
            case "l_level10":
               LevelUtils.initLevel(Level.LEVEL_10);
               break;
            case "l_level11":
               LevelUtils.initLevel(Level.LEVEL_11);
               break;
            case "wipe":
               WipeHandler.beginSwipe(null,null,false);
            case "SS_0":
               EffectIndicator.self.addStatus(0);
               break;
            case "SS_1":
               EffectIndicator.self.addStatus(1);
               break;
            case "SS_2":
               EffectIndicator.self.addStatus(2);
               break;
            case "SS_3":
               EffectIndicator.self.addStatus(3);
               break;
            case "SS_4":
               EffectIndicator.self.addStatus(4);
               break;
            case "SE_0":
               EffectIndicator.self.removeStatus(0);
               break;
            case "SE_1":
               EffectIndicator.self.removeStatus(1);
               break;
            case "SE_2":
               EffectIndicator.self.removeStatus(2);
               break;
            case "SE_3":
               EffectIndicator.self.removeStatus(3);
               break;
            case "SE_4":
               EffectIndicator.self.removeStatus(4);
               break;
            case "DK_toggle":
               global.DK = !global.DK;
               break;
            case "score":
               ScoreHandler.debugScore();
         }
      }
      
      public function addB(param1:String) : *
      {
         var _loc2_:Number = this.xs * this.xGrid;
         var _loc3_:Number = this.ys * this.yGrid;
         addChild(new eButton(_loc2_ + 150,_loc3_ + 60,param1,this,param1));
         this.ys = this.ys + 1;
         if(this.ys > 8)
         {
            this.ys = 0;
            this.xs++;
         }
      }
   }
}
