package
{
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import objects.cCar;
   import objects.cProjectileGun;
   
   public class StatusHandler extends fudgepoppy
   {
      
      public static var self:StatusHandler;
      
      public static var myParent:Sprite;
      
      public static const LABEL_SIZE:int = 26;
      
      public static const LABEL_COLOR:uint = 16777215;
      
      public static const LABEL_EFFECT:uint = 0;
      
      public static const LABEL_DEFAULT_Y:uint = global.gameHeight - 15;
      
      public static var mgButton:eButton = new eButton(0,0,global.pmg_button_title,UIHandler.self,global.pmg_button_command_ingame);
      
      public static var btnLoad:iButton = new iButton("Loadlevel",UIHandler.self,buttonLoad,85,60);
      
      public static var btnSave:iButton = new iButton("Savelevel",UIHandler.self,buttonSave,40,60);
      
      public static var btnDel:iButton = new iButton("Deletelast",UIHandler.self,buttonNewUp,130,60);
      
      public static var btnMenuExit:eButton = new eButton(45,global.gameHeight - 40,"Menu",UIHandler.self,"iconX");
      
      public static var btnMenuSound:eButton = new eButton(60,global.gameHeight - 40,"S",UIHandler.self,"iconSM");
      
      public static var btnMenuReset:eButton = new eButton(84,global.gameHeight - 40,"R",UIHandler.self,"iconR");
      
      public static var btnMenuMusic:iButton = new iButton("iconM",UIHandler.self,new_icon_m,165,462);
      
      public static var labelTopLeft:customFont = new customFont(LABEL_SIZE,"|",true,LABEL_COLOR,LABEL_EFFECT,false,0,true);
      
      public static var labelMiddle:customFont = new customFont(LABEL_SIZE,"|",true,LABEL_COLOR,LABEL_EFFECT,false,0,true);
      
      public static var labelTopRight:customFont = new customFont(LABEL_SIZE,"|",true,LABEL_COLOR,LABEL_EFFECT,false,0,true);
      
      public static var statusTopRight:String = " ";
      
      public static var statusMiddle:String = " ";
      
      public static var statusTopLeft:String = " ";
      
      public static var iconTopLeft:Sprite = new Sprite();
      
      public static var iconMiddle:Sprite = new Sprite();
      
      public static var iconTopRight:Sprite = new Sprite();
      
      private static var targScalex:Number;
      
      public static var worldCar:cCar;
       
      
      public function StatusHandler(param1:Sprite)
      {
         super();
         myParent = param1;
         self = this;
         initStuff();
      }
      
      public static function initStuff() : void
      {
         labelTopLeft.y = 10;
         labelMiddle.y = 10;
         labelTopRight.y = 10;
         labelTopLeft.visible = false;
         labelMiddle.visible = false;
         labelTopRight.visible = false;
         StatusHandler.self.addChild(labelTopLeft);
         StatusHandler.self.addChild(labelTopRight);
         StatusHandler.self.addChild(labelMiddle);
         labelTopLeft.x = 70;
         labelTopLeft.y = 20;
         labelTopRight.x = global.gameWidth - 150;
         labelTopRight.y = 20;
         labelMiddle.x = 200;
         labelMiddle.y = -200;
         self.addChild(btnSave);
         self.addChild(btnDel);
         myParent.addChild(self);
         MakeButton.make(self.ingame.button_sound,"iconMS",true);
         MakeButton.make(self.ingame.button_help,"help",true);
      }
      
      public static function cleanup() : void
      {
         statusTopLeft = " ";
         statusTopRight = " ";
         statusMiddle = " ";
      }
      
      public static function tick() : void
      {
         btnSave.visible = World.currentLevel.inEditor;
         btnLoad.visible = World.currentLevel.inEditor;
         btnDel.visible = World.currentLevel.inEditor;
         if(labelTopLeft.currentText != statusTopLeft)
         {
            labelTopLeft.drawHtml(statusTopLeft);
         }
         if(labelTopRight.currentText != statusTopRight)
         {
            labelTopRight.drawHtml(statusTopRight);
         }
         if(labelMiddle.currentText != statusMiddle)
         {
            labelMiddle.drawHtml(statusMiddle);
         }
         labelTopLeft.visible = !PopupHandler.menuActive();
         labelMiddle.visible = !PopupHandler.menuActive();
         labelTopRight.visible = !PopupHandler.menuActive();
         self.ingame.visible = !PopupHandler.menuActive();
         iconTopLeft.visible = statusTopLeft != " ";
         iconTopRight.visible = statusTopRight != " ";
         iconMiddle.visible = statusMiddle != " ";
         if(labelTopRight.scaleX < 1)
         {
            labelTopRight.scaleX = labelTopRight.scaleX + 0.1;
         }
         if(labelTopRight.scaleY < 1)
         {
            labelTopRight.scaleY = labelTopRight.scaleY + 0.1;
         }
         if(labelMiddle.scaleX < 1)
         {
            labelMiddle.scaleX = labelMiddle.scaleX + 0.1;
         }
         if(labelMiddle.scaleY < 1)
         {
            labelMiddle.scaleY = labelMiddle.scaleY + 0.1;
         }
         if(World.followObj != null && !GameMode.goal && !GameMode.failed)
         {
            worldCar = World.followObj as cCar;
            updateBullets();
            updateGrenades();
            updateLives();
            updateTime();
            self.ingame.scorepad.visible = false;
            updateReadouts();
            updateHealth();
         }
      }
      
      public static function updateHealth() : void
      {
         var _loc1_:Number = World.followObj.slugCast.slug_health;
         var _loc2_:Number = World.followObj.slugCast.slug_default_health;
         var _loc3_:Number = _loc1_ / _loc2_;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         targScalex = _loc3_;
         self.ingame.scrollybit.innerbit.scaleX = self.ingame.scrollybit.innerbit.scaleX + (targScalex - self.ingame.scrollybit.innerbit.scaleX) / 10;
         if(_loc3_ < 0.2)
         {
            self.ingame.scrollybit.visible = GameMode.gameMode.frameCount % 40 > 20;
         }
         else
         {
            self.ingame.scrollybit.visible = true;
         }
      }
      
      public static function updateReadouts() : void
      {
         var _loc1_:Boolean = SlugScore.has_weapons[cProjectileGun.TYPE_PISTOL] && SlugScore.hasEnoughBullets(cProjectileGun.TYPE_PISTOL);
         if(SlugScore.hasEnoughBullets(cProjectileGun.TYPE_MACHINEGUN))
         {
            self.ingame.r2.transform.colorTransform = new ColorTransform(1,1,1);
         }
         else
         {
            self.ingame.r2.transform.colorTransform = new ColorTransform(3,0.5,0.5);
         }
         if(SlugScore.hasEnoughBullets(cProjectileGun.TYPE_SHOTGUN))
         {
            self.ingame.r3.transform.colorTransform = new ColorTransform(1,1,1);
         }
         else
         {
            self.ingame.r3.transform.colorTransform = new ColorTransform(3,0.5,0.5);
         }
         if(SlugScore.hasEnoughBullets(cProjectileGun.TYPE_GRENADE))
         {
            self.ingame.r4.transform.colorTransform = new ColorTransform(1,1,1);
            self.ingame.r5.transform.colorTransform = new ColorTransform(1,1,1);
         }
         else
         {
            self.ingame.r4.transform.colorTransform = new ColorTransform(3,0.5,0.5);
            self.ingame.r5.transform.colorTransform = new ColorTransform(3,0.5,0.5);
         }
         self.ingame.r1.alpha = worldCar.weapon_type == cProjectileGun.TYPE_PISTOL?Number(1):Number(0.5);
         self.ingame.r2.alpha = worldCar.weapon_type == cProjectileGun.TYPE_MACHINEGUN?Number(1):Number(0.5);
         self.ingame.r3.alpha = worldCar.weapon_type == cProjectileGun.TYPE_SHOTGUN?Number(1):Number(0.5);
         self.ingame.r4.alpha = !!SlugScore.hasEnoughBullets(cProjectileGun.TYPE_GRENADE)?Number(1):Number(0.5);
         self.ingame.r5.alpha = self.ingame.r4.alpha;
      }
      
      public static function updateBullets() : *
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc1_:int = worldCar.weapon_type;
         if(_loc1_ == cProjectileGun.TYPE_PISTOL)
         {
            self.ingame.amr.gotoAndStop(1);
         }
         else
         {
            self.ingame.amr.gotoAndStop(2);
            _loc2_ = SlugScore.getBulletString(_loc1_);
            _loc3_ = _loc2_.charAt(2);
            _loc4_ = _loc2_.charAt(1);
            _loc5_ = _loc2_.charAt(0);
            self.ingame.amr["amr100"].gotoAndStop(Number(_loc5_) + 1);
            self.ingame.amr["amr10"].gotoAndStop(Number(_loc4_) + 1);
            self.ingame.amr["amr1"].gotoAndStop(Number(_loc3_) + 1);
         }
      }
      
      public static function updateGrenades() : *
      {
         var _loc1_:int = cProjectileGun.TYPE_GRENADE;
         var _loc2_:String = SlugScore.getBulletString(_loc1_);
         var _loc3_:String = _loc2_.charAt(2);
         var _loc4_:String = _loc2_.charAt(1);
         self.ingame.bomb["bomb10"].gotoAndStop(Number(_loc4_) + 1);
         self.ingame.bomb["bomb1"].gotoAndStop(Number(_loc3_) + 1);
      }
      
      public static function updateLives() : *
      {
         var _loc1_:String = GameMode.pad3(worldCar.getLives().toString());
         var _loc2_:String = _loc1_.charAt(2);
         var _loc3_:String = _loc1_.charAt(1);
         self.ingame.life.gotoAndStop(Number(_loc2_) + 1);
      }
      
      public static function updateTime() : *
      {
         var _loc1_:String = GameMode.pad3(statusMiddle);
         var _loc2_:String = _loc1_.charAt(4);
         var _loc3_:String = _loc1_.charAt(3);
         self.ingame.time_pad["num10"].gotoAndStop(Number(_loc3_) + 1);
         self.ingame.time_pad["num1"].gotoAndStop(Number(_loc2_) + 1);
         if(_loc1_ == "00000")
         {
            self.ingame.time_pad.visible = GameMode.gameMode.frameCount % 20 > 10;
         }
         else
         {
            self.ingame.time_pad.visible = true;
         }
      }
      
      public function buttonPressed(param1:String) : *
      {
         UIHandler.self.buttonPressed(param1);
      }
   }
}
