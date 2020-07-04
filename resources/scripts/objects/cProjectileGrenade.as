package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import nape.geom.Vec2;
   import nape.phys.BodyType;
   
   public class cProjectileGrenade extends cProjectile
   {
       
      
      public var puddle:Boolean = false;
      
      public var bombClip:MovieClip;
      
      public var payLoaded:Boolean = false;
      
      public var manual_flag:int = -1;
      
      public var grenadeFlaggedOnce:Boolean = false;
      
      public function cProjectileGrenade(param1:Number, param2:Number, param3:GameMode, param4:Number = 0, param5:Boolean = false)
      {
         this.puddle = param5;
         super(param1,param2,param3,param4);
         bodyParts[0].gravMassScale = 0.5;
         bodyParts[0].userData.isWheel = true;
      }
      
      override public function getStats() : void
      {
         super.getStats();
         dealsTouchDamage = 40;
         touchDamageDelay = -1;
         random_y_spread = 0;
         projectile_speed = 180;
         lifetime = 50;
         hitRect = new Rectangle(0,0,50,50);
         projectile_collides = true;
         this.bombClip = this.getMyClip();
         myBodyClip.addChild(this.bombClip);
         this.bombClip.gotoAndStop(1);
      }
      
      override public function dealtDamage(param1:slugObject, param2:int) : void
      {
         super.dealtDamage(param1,param2);
         this.payLoad();
      }
      
      override public function gotFlagged() : void
      {
         super.gotFlagged();
         if(!this.grenadeFlaggedOnce)
         {
            this.payLoad();
            this.grenadeFlaggedOnce = true;
         }
      }
      
      public function payLoad() : void
      {
         if(!this.payLoaded)
         {
            flagged = false;
            flaggedTimer = -1;
            this.manual_flag = 5;
            touchDamageDelay = 2;
            bodyParts[0].velocity = new Vec2();
            bodyParts[0].angularVel = 0;
            hitRect = new Rectangle(0,0,150,150);
            this.payLoaded = true;
            useFollowAngles = false;
            useLastAngle = false;
            bodyParts[0].userData.clipRotationSource = GroundUtils.ground;
            bodyParts[0].type = BodyType.STATIC;
            this.subLoad();
            this.doAni();
            SoundHandler.playSoundClass(sound_asplosion);
         }
      }
      
      public function getMyClip() : MovieClip
      {
         var _loc1_:MovieClip = null;
         if(this.puddle)
         {
            _loc1_ = new bomb01();
            if(World.followObj != null && World.followObj.currentX > currentX)
            {
               _loc1_.scaleX = -1;
            }
            return _loc1_;
         }
         return new npc_shoot04();
      }
      
      public function doAni() : void
      {
         useFollowAngles = false;
         bodyParts[0].userData.clipRotationSource = GroundUtils.ground;
         var _loc1_:int = 0;
         while(_loc1_ < myBodyClip.numChildren)
         {
            myBodyClip.getChildAt(_loc1_).rotation = 0;
            _loc1_++;
         }
         if(this.puddle)
         {
            this.bombClip.gotoAndStop("explode");
         }
         else
         {
            this.bombClip.gotoAndStop("hit");
         }
      }
      
      public function subLoad() : void
      {
         myBodyClip.scaleX = 2;
         myBodyClip.scaleY = 2;
      }
      
      override public function createBody() : void
      {
         part_main = BoxUtils.NewCircle(x,y,2,1,true,Filters.fuckall,Filters.fuckallMask);
         lastPart = part_main;
         addPart(part_main);
      }
      
      override public function slugtick() : void
      {
         var _loc1_:Boolean = false;
         super.slugtick();
         if(this.manual_flag > -1)
         {
            this.manual_flag--;
            if(this.manual_flag == -1)
            {
               flaggedTimer = 0;
            }
         }
         if(bodyParts.length > 0 && bodyParts[0] != null)
         {
            _loc1_ = bodyParts[0].userData.groundConnected;
            if(_loc1_)
            {
               this.payLoad();
            }
         }
      }
   }
}
