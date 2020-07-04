package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public class cProjectileGun extends cProjectile
   {
      
      public static const TYPE_PISTOL:int = 0;
      
      public static const TYPE_MACHINEGUN:int = 1;
      
      public static const TYPE_RIFLE:int = 2;
      
      public static const TYPE_SHOTGUN:int = 3;
      
      public static const TYPE_BAZOOKA:int = 4;
      
      public static const NUM_PROJECTILE_TYPES:int = 5;
      
      public static const TYPE_GRENADE:int = 5;
       
      
      public var myType:int = 0;
      
      public var bulletclip:MovieClip;
      
      var madeProxy:Boolean = false;
      
      public function cProjectileGun(param1:Number, param2:Number, param3:GameMode, param4:Number = 0, param5:int = 0, param6:Boolean = false)
      {
         this.myType = param5;
         hostile = param6;
         super(param1,param2,param3,param4);
         if(param5 == TYPE_SHOTGUN)
         {
            lifetime = 6;
         }
         if(this.myType == TYPE_BAZOOKA || this.myType == TYPE_RIFLE)
         {
            bodyParts[0].userData.clipRotationSource = GroundUtils.ground;
            useFollowAngles = false;
         }
      }
      
      public static function getMaxBulletsForType(param1:int) : int
      {
         switch(param1)
         {
            default:
               return 500;
            case TYPE_MACHINEGUN:
               return 300;
            case TYPE_RIFLE:
               return 0;
            case TYPE_SHOTGUN:
               return 50;
            case TYPE_BAZOOKA:
               return 0;
            case TYPE_GRENADE:
               return 6;
         }
      }
      
      public static function getDefaultBulletsForType(param1:int) : int
      {
         switch(param1)
         {
            default:
               return 500;
            case TYPE_MACHINEGUN:
               return 100;
            case TYPE_RIFLE:
               return 0;
            case TYPE_SHOTGUN:
               return 20;
            case TYPE_BAZOOKA:
               return 0;
            case TYPE_GRENADE:
               return 2;
         }
      }
      
      public static function getYOffsetForType(param1:int) : Number
      {
         switch(param1)
         {
            default:
               return 0;
            case TYPE_MACHINEGUN:
               return 14;
            case TYPE_RIFLE:
               return 8;
            case TYPE_SHOTGUN:
               return 14;
            case TYPE_BAZOOKA:
               return 0;
         }
      }
      
      public static function getRateForType(param1:int) : int
      {
         switch(param1)
         {
            default:
               return 5;
            case TYPE_MACHINEGUN:
               return 2;
            case TYPE_RIFLE:
               return 6;
            case TYPE_SHOTGUN:
               return 18;
            case TYPE_BAZOOKA:
               return 18;
         }
      }
      
      override public function gotFlagged() : void
      {
         super.gotFlagged();
         flaggedTimer = 9;
         if(this.bulletclip.totalFrames >= 6)
         {
            this.bulletclip.gotoAndPlay(6);
         }
      }
      
      override public function dealtDamage(param1:slugObject, param2:int) : void
      {
         super.dealtDamage(param1,param2);
         useFollowAngles = false;
         useLastAngle = true;
      }
      
      override public function subTick() : void
      {
         super.subTick();
         if(framecount >= lifetime - 10)
         {
            if(this.bulletclip.totalFrames >= 19)
            {
               this.bulletclip.gotoAndStop(20);
            }
         }
      }
      
      override public function createGraphics() : void
      {
         super.createGraphics();
         this.bulletclip = this.getBulletClip();
         myBodyClip.addChild(this.bulletclip);
         this.bulletclip.play();
      }
      
      public function getBulletClip() : MovieClip
      {
         switch(this.myType)
         {
            default:
               return new shoot0();
            case TYPE_MACHINEGUN:
               return new shoot1();
            case TYPE_RIFLE:
               return new shoot0();
            case TYPE_SHOTGUN:
               return new shoot0();
            case TYPE_BAZOOKA:
               return new shoot2();
         }
      }
      
      override public function getSpread() : void
      {
         random_y_spread = this.getSpreadForType();
      }
      
      override public function getStats() : void
      {
         super.getStats();
         dealsTouchDamage = this.getDamageForType();
         projectile_speed = this.getSpeedForType();
         touchDamageDelay = -1;
         hitRect = this.getSizeForType();
         lifetime = 100;
         projectile_collides = false;
         takesDamage = false;
      }
      
      override public function slugtick() : void
      {
         var _loc1_:cShottieBlob = null;
         super.slugtick();
         if(this.myType == TYPE_SHOTGUN)
         {
            if(!this.madeProxy)
            {
               this.madeProxy = true;
               _loc1_ = new cShottieBlob(currentX,currentY,GameMode.gameMode,bodyParts[0].velocity.angle);
               LevelUtils.levelOb(_loc1_);
            }
         }
      }
      
      override public function getTypeStringLol() : String
      {
         return this.myType.toString();
      }
      
      override public function getSpawnSound() : Class
      {
         switch(this.myType)
         {
            default:
               return sound_pistol_silenced;
            case TYPE_MACHINEGUN:
               return sound_pistol_silenced_2;
            case TYPE_RIFLE:
               return sound_clicking;
            case TYPE_SHOTGUN:
               return sound_shotgun;
            case TYPE_BAZOOKA:
               return sound_bazooka;
            case TYPE_GRENADE:
               return sound_clicking;
         }
      }
      
      public function getSizeForType() : Rectangle
      {
         switch(this.myType)
         {
            default:
               return new Rectangle(0,0,30,30);
            case TYPE_MACHINEGUN:
               return new Rectangle(0,0,40,40);
            case TYPE_RIFLE:
               return new Rectangle(0,0,30,30);
            case TYPE_SHOTGUN:
               return new Rectangle(0,0,80,80);
            case TYPE_BAZOOKA:
               return new Rectangle(0,0,30,30);
         }
      }
      
      public function getSpeedForType() : int
      {
         switch(this.myType)
         {
            default:
               return 250;
            case TYPE_MACHINEGUN:
               return 270;
            case TYPE_RIFLE:
               return 200;
            case TYPE_SHOTGUN:
               return 400;
         }
      }
      
      public function getDamageForType() : int
      {
         switch(this.myType)
         {
            default:
               return 30;
            case TYPE_MACHINEGUN:
               return 14;
            case TYPE_RIFLE:
               return 40;
            case TYPE_SHOTGUN:
               return 110;
         }
      }
      
      public function getSpreadForType() : int
      {
         switch(this.myType)
         {
            default:
               return 3;
            case TYPE_MACHINEGUN:
               return 10;
            case TYPE_RIFLE:
               return 7;
            case TYPE_SHOTGUN:
               return 2;
         }
      }
   }
}
