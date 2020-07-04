package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import nape.geom.Vec2;
   
   public class cAICopter extends cAIShooter
   {
      
      public static var state_buzzing:int = 0;
      
      public static var state_hovering:int = 1;
      
      public static var state_buzzout:int = 2;
      
      public static var state_falling:int = 3;
       
      
      public var targSpot:Vec2;
      
      public var tempTarg:Vec2;
      
      public var copterGraphic:sluggie_copter;
      
      public var active:Boolean = true;
      
      public var state:int = 0;
      
      public var frameCount:int = 0;
      
      public var hoverCount:int = -1;
      
      public var buzzoutCount:int = -1;
      
      public var hasBeenInRange:Boolean = false;
      
      public var lir:Boolean = false;
      
      public var ir:Boolean = false;
      
      public var didDeactivate:Boolean = false;
      
      public function cAICopter(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         this.targSpot = new Vec2();
         this.copterGraphic = new sluggie_copter();
         super(param1,param2,param3,param4);
         if(!World.currentLevel.inEditor)
         {
            this.targSpot = new Vec2(World.followObj.currentX,80);
            this.tempTarg = this.targSpot.copy();
            translateMe(200,-150);
            this.randomiseTargSpot();
         }
      }
      
      override public function getProjectileClass() : Class
      {
         return cProjectileBomb;
      }
      
      override public function getTypeStringLol() : String
      {
         return "Copter";
      }
      
      override public function doFire() : void
      {
         super.doFire();
         SoundHandler.playSoundClass(sound_bombdrop);
      }
      
      override public function getStats() : void
      {
         var _loc1_:customFont = null;
         super.getStats();
         buildStatic = false;
         myBodyClip = new MovieClip();
         if(slugObject.showNames)
         {
            _loc1_ = new customFont(12,this.getTypeStringLol(),true);
            myBodyClip.addChild(_loc1_);
         }
         this.copterGraphic.x = -this.copterGraphic.width / 2;
         this.copterGraphic.y = -this.copterGraphic.height / 2;
         myBodyClip.addChild(this.copterGraphic);
         dealsTouchDamage = -1;
         touchDamageDelay = 0;
         hitRect = new Rectangle(0,0,180,40);
         shootAngle = 180;
         hostile = true;
         slug_health = getDefaultEnemyHealth() * 4;
         fire_delay = 8;
         is_camlock_enemy = true;
      }
      
      public function randomiseTargSpot() : void
      {
         this.targSpot.x = World.followObj.currentX;
         this.targSpot.y = 100;
         this.tempTarg.x = this.targSpot.x + Math.random() * 100 - 50;
         this.tempTarg.y = this.targSpot.y + Math.random() * -40;
      }
      
      public function setExitSpot() : void
      {
         this.randomiseTargSpot();
      }
      
      override public function amVisible() : Boolean
      {
         return super.amVisible() || this.hasBeenInRange;
      }
      
      public function inRange() : Boolean
      {
         if(this.hasBeenInRange)
         {
            return true;
         }
         if(Math.abs(World.followObj.currentX - currentX) < 900)
         {
            this.hasBeenInRange = true;
            return true;
         }
         return false;
      }
      
      override public function slugtick() : void
      {
         var _loc1_:Vec2 = null;
         super.slugtick();
         this.ir = this.inRange();
         if(this.ir && !this.lir)
         {
            this.randomiseTargSpot();
         }
         this.lir = this.ir;
         if(this.active && this.inRange() && World.followObj.slugCast.slug_health > 0)
         {
            isAlwaysEnabled = true;
            part_main.rotation = 0;
            if(this.state == state_buzzing)
            {
               _loc1_ = part_main.position.copy().sub(this.tempTarg);
               if(_loc1_.length < 40)
               {
                  this.hoverCount = 300;
                  this.state = state_hovering;
               }
               else
               {
                  this.smoothVec(_loc1_);
                  part_main.position.x = part_main.position.x + (this.tempTarg.x - part_main.position.x) / 20;
                  part_main.position.y = part_main.position.y + (this.tempTarg.y - part_main.position.y) / 25;
               }
            }
            firing = this.state == state_hovering && this.frameCount % 100 > 75 && !World.currentLevel.myID == Level.LEVEL_INTRO;
            if(this.state == state_hovering)
            {
               _loc1_ = part_main.position.copy().sub(this.tempTarg);
               if(this.hoverCount % 10 == 0)
               {
                  this.randomiseTargSpot();
               }
               this.smoothVec(_loc1_);
               part_main.applyWorldForce(_loc1_);
               if(this.hoverCount > -1)
               {
                  this.hoverCount--;
                  if(this.hoverCount == -1)
                  {
                     this.setExitSpot();
                     this.state = state_buzzout;
                     this.buzzoutCount = 30;
                  }
               }
               else
               {
                  if(!GameMode.goal && !GameMode.failed)
                  {
                  }
                  this.hoverCount = 200;
               }
            }
            if(this.state == state_buzzout)
            {
               _loc1_ = part_main.position.copy().sub(this.tempTarg);
               part_main.position.x = part_main.position.x + (this.tempTarg.x - part_main.position.x) / 20;
               part_main.position.y = part_main.position.y + (this.tempTarg.y - part_main.position.y) / 25;
               if(this.buzzoutCount > -1)
               {
                  this.buzzoutCount--;
                  if(this.buzzoutCount == -1)
                  {
                     this.randomiseTargSpot();
                     this.state = state_hovering;
                  }
               }
            }
         }
         if(flaggedTimer > -1 || flagged)
         {
            this.active = false;
            this.state = state_falling;
            part_main.gravMassScale = 1;
            part_main.angularVel = -5000;
         }
         if(flaggedTimer == 0)
         {
            myBodyClip.scaleX = 4;
         }
         this.frameCount++;
      }
      
      override public function death() : void
      {
         super.death();
         SoundHandler.playSoundClass(sound_asplosion);
      }
      
      public function smoothVec(param1:Vec2) : void
      {
         if(param1.length != 0)
         {
            param1.length = 1 / param1.length;
         }
         if(param1.length < 50)
         {
            param1.length = 50;
         }
         param1.muleq(-1);
      }
      
      override public function takeDamage(param1:slugObject, param2:int) : void
      {
         super.takeDamage(param1,param2);
      }
   }
}
