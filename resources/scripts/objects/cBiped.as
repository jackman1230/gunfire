package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   import nape.geom.Vec2;
   
   public class cBiped extends slugObject
   {
      
      public static const D_PERFECT_UP:int = 0;
      
      public static const D_UPRIGHTEXTREME:int = 1;
      
      public static const D_UPRIGHT:int = 2;
      
      public static const D_NEWRIGHT:int = 3;
      
      public static const D_RIGHT:int = 4;
      
      public static const D_NEWDOWNRIGHT:int = 5;
      
      public static const D_DOWNRIGHT:int = 6;
      
      public static const D_DOWNRIGHTEXTREME:int = 7;
      
      public static const D_PERFECT_DOWN:int = 8;
      
      public static const D_DOWNLEFTEXTREME:int = 9;
      
      public static const D_DOWNLEFT:int = 10;
      
      public static const D_NEWDOWNLEFT:int = 11;
      
      public static const D_LEFT:int = 12;
      
      public static const D_NEWLEFT:int = 13;
      
      public static const D_UPLEFT:int = 14;
      
      public static const D_UPLEFTEXTREME:int = 15;
       
      
      public var part_main:Boner;
      
      public var facingLeft:Boolean = false;
      
      public var direction:int = 2;
      
      public var fire_delay:int = 5;
      
      public var fire_count:int = -1;
      
      public var weapon_type:int = 0;
      
      public var hasWeapons:Array;
      
      public var wanderDistance:int = 100;
      
      public var isSwordsMan:Boolean = false;
      
      public var isHitler:Boolean = false;
      
      public var isTank:Boolean = false;
      
      public var can_notlook:Boolean = false;
      
      private var tempHitRect:Rectangle;
      
      public var spawned_death_stuff_already:Boolean = false;
      
      public function cBiped(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         this.hasWeapons = [true,false,false,false];
         super(param1,param2,param3,param4);
         this.createBody();
         this.createGraphics();
         postCreate();
      }
      
      public static function getEjectionpoint(param1:int, param2:slugObject = null) : Vec2
      {
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         switch(param1)
         {
            default:
               _loc3_ = 0;
               _loc4_ = 0;
               break;
            case D_PERFECT_UP:
               _loc3_ = 0;
               _loc4_ = 0;
               break;
            case D_UPRIGHTEXTREME:
               _loc3_ = 20;
               _loc4_ = -45;
               break;
            case D_UPRIGHT:
               _loc3_ = 28;
               _loc4_ = -24;
               break;
            case D_NEWRIGHT:
               _loc3_ = 40;
               _loc4_ = -10;
               break;
            case D_RIGHT:
               _loc3_ = 50;
               _loc4_ = 0;
               break;
            case D_NEWDOWNRIGHT:
               _loc3_ = 48;
               _loc4_ = 10;
               break;
            case D_DOWNRIGHT:
               _loc3_ = 48;
               _loc4_ = 36;
               break;
            case D_DOWNRIGHTEXTREME:
               _loc3_ = 20;
               _loc4_ = 50;
               break;
            case D_PERFECT_DOWN:
               _loc3_ = 0;
               _loc4_ = 50;
               break;
            case D_DOWNLEFTEXTREME:
               _loc3_ = -20;
               _loc4_ = 50;
               break;
            case D_DOWNLEFT:
               _loc3_ = -48;
               _loc4_ = 36;
               break;
            case D_NEWDOWNLEFT:
               _loc3_ = -48;
               _loc4_ = 10;
               break;
            case D_LEFT:
               _loc3_ = -50;
               _loc4_ = 0;
               break;
            case D_NEWLEFT:
               _loc3_ = -40;
               _loc4_ = -10;
               break;
            case D_UPLEFT:
               _loc3_ = -28;
               _loc4_ = -24;
               break;
            case D_UPLEFTEXTREME:
               _loc3_ = -20;
               _loc4_ = -45;
         }
         if(param2 is cCar && (param2 as cCar).weapon_type == cProjectileGun.TYPE_MACHINEGUN)
         {
            _loc3_ = _loc3_ * 0.4;
            _loc4_ = _loc4_ * 0.4;
         }
         _loc4_ = _loc4_ - 50;
         if(param2 != null)
         {
            if(param2 is cSoldier && ((param2 as cSoldier).myHandler as AICarHandler).crouchey_ai)
            {
               _loc4_ = _loc4_ + 50;
            }
         }
         return new Vec2(_loc3_,_loc4_);
      }
      
      public static function pp(param1:Number) : Number
      {
         return 25.7 * param1;
      }
      
      public static function directionToAngle(param1:int, param2:cBiped) : Number
      {
         switch(param1)
         {
            default:
               return 0;
            case D_PERFECT_UP:
               return 0;
            case D_UPRIGHTEXTREME:
               return pp(0.5);
            case D_UPRIGHT:
               return pp(1.5);
            case D_NEWRIGHT:
               return pp(2.5);
            case D_RIGHT:
               return pp(3.5);
            case D_NEWDOWNRIGHT:
               return pp(4.5) - 8;
            case D_DOWNRIGHT:
               return pp(5.5);
            case D_DOWNRIGHTEXTREME:
               return pp(6.5);
            case D_UPLEFTEXTREME:
               return pp(-0.5);
            case D_UPLEFT:
               return pp(-1.5);
            case D_NEWLEFT:
               return pp(-2.5);
            case D_LEFT:
               return pp(-3.5);
            case D_NEWDOWNLEFT:
               return pp(-4.5) + 8;
            case D_DOWNLEFT:
               return pp(-5.5);
            case D_DOWNLEFTEXTREME:
               return pp(-6.5);
            case D_PERFECT_DOWN:
               return 180;
         }
      }
      
      override public function getStats() : void
      {
         var _loc1_:customFont = null;
         super.getStats();
         graphicScale = 1;
         isBreakable = true;
         isBounceTrigger = false;
         isCar = true;
         isAlwaysEnabled = false;
         takesDamage = true;
         myBodyClip = new MovieClip();
         if(slugObject.showNames)
         {
            _loc1_ = new customFont(12,getQualifiedClassName(this),true);
            myBodyClip.addChild(_loc1_);
         }
         hitRect = new Rectangle(0,-30,50,70);
      }
      
      public function hitRectCrouch(param1:Boolean = false) : void
      {
         if(this.tempHitRect == null)
         {
            this.tempHitRect = hitRect.clone();
         }
         if(param1)
         {
            hitRect.height = this.tempHitRect.height * 0.4;
            hitRectOffsetY = 20;
         }
         else
         {
            hitRect.height = this.tempHitRect.height * 1;
            hitRectOffsetY = 0;
         }
      }
      
      public function createBody() : void
      {
         this.part_main = BoxUtils.NewCircle(x,y,20,1,true,Filters.car,Filters.carMask,1,0);
         lastPart = this.part_main;
         lastPart.userData.isWheel = true;
         addPart(this.part_main);
         this.part_main.spriteOffsetY = 22;
      }
      
      override public function death() : void
      {
         var _loc1_:* = false;
         var _loc2_:Number = NaN;
         super.death();
         if(!playerControlled && !this.spawned_death_stuff_already)
         {
            _loc1_ = Math.random() > 0.5;
            _loc2_ = Math.random();
            if(_loc1_ || currentX < 1900)
            {
               if(_loc2_ > 0.9)
               {
                  this.spawnPickup(cPickupLife);
               }
               else if(_loc2_ > 0.7)
               {
                  this.spawnPickup(cPickupGun3);
               }
               else if(_loc2_ > 0.5)
               {
                  this.spawnPickup(cPickupGun4);
               }
               else
               {
                  this.spawnPickup(cPickupGun2);
               }
            }
            this.spawned_death_stuff_already = true;
         }
         this.playDeathSound();
      }
      
      public function playDeathSound() : void
      {
         var _loc1_:Number = NaN;
         if(!playerControlled)
         {
            if(Math.random() > 0.5)
            {
               SoundHandler.playSoundClass(sound_enemy_die_1);
            }
            else
            {
               SoundHandler.playSoundClass(sound_enemy_die_2);
            }
         }
         else
         {
            _loc1_ = Math.random();
            if(_loc1_ > 0.75)
            {
               SoundHandler.playSoundClass(sound_die_1);
            }
            else if(_loc1_ > 0.5)
            {
               SoundHandler.playSoundClass(sound_die_2);
            }
            else if(_loc1_ > 0.25)
            {
               SoundHandler.playSoundClass(sound_die_3);
            }
            else
            {
               SoundHandler.playSoundClass(sound_die_4);
            }
         }
      }
      
      public function spawnPickup(param1:Class) : void
      {
         LevelUtils.levelOb(new param1(currentX,currentY - 40,GameMode.gameMode,0));
      }
      
      public function doFire() : void
      {
         var _loc1_:Class = null;
         var _loc2_:Vec2 = null;
         var _loc3_:slugObject = null;
         if(!playerControlled)
         {
         }
         if(SlugScore.hasEnoughBullets(this.weapon_type) || !playerControlled)
         {
            _loc1_ = this.getProjectileClass();
            _loc2_ = getEjectionpoint(this.direction,this);
            _loc2_.y = _loc2_.y + (cProjectileGun.getYOffsetForType(this.weapon_type) + 15);
            _loc3_ = new _loc1_(currentX + _loc2_.x,currentY + _loc2_.y,GameMode.gameMode,directionToAngle(this.direction,this),this.weapon_type,hostile) as slugObject;
            _loc3_.hostile = hostile;
            LevelUtils.levelOb(_loc3_);
            myHandler.shotFired();
            if(playerControlled)
            {
               SlugScore.numBullets[this.weapon_type] = SlugScore.numBullets[this.weapon_type] + 1;
            }
         }
         else
         {
            SoundHandler.playSoundClass(sound_emptyweapon);
            if(this.weapon_type == cProjectileGun.TYPE_SHOTGUN)
            {
               if(SlugScore.hasEnoughBullets(cProjectileGun.TYPE_MACHINEGUN))
               {
                  this.setWeapon(cProjectileGun.TYPE_MACHINEGUN);
               }
               else
               {
                  this.setWeapon(cProjectileGun.TYPE_PISTOL);
               }
            }
            else if(this.weapon_type == cProjectileGun.TYPE_MACHINEGUN)
            {
               if(SlugScore.hasEnoughBullets(cProjectileGun.TYPE_SHOTGUN))
               {
                  this.setWeapon(cProjectileGun.TYPE_SHOTGUN);
               }
               else
               {
                  this.setWeapon(cProjectileGun.TYPE_PISTOL);
               }
            }
         }
      }
      
      public function doGrenade() : void
      {
         var _loc1_:int = !!this.facingLeft?int(D_UPLEFT):int(D_UPRIGHT);
         var _loc2_:slugObject = new cProjectileGrenade(currentX,currentY - 50,GameMode.gameMode,directionToAngle(_loc1_,this),playerControlled);
         _loc2_.hostile = hostile;
         LevelUtils.levelOb(_loc2_);
         myHandler.shotFired();
         if(playerControlled)
         {
            SlugScore.numBullets[cProjectileGun.TYPE_GRENADE] = SlugScore.numBullets[cProjectileGun.TYPE_GRENADE] + 1;
         }
      }
      
      public function doKnife() : void
      {
         var _loc4_:* = undefined;
         var _loc1_:int = !!this.facingLeft?int(D_LEFT):int(D_RIGHT);
         var _loc2_:Number = 0;
         if(_loc1_ > 0 && _loc1_ < 4)
         {
            _loc2_ = 50;
         }
         if(_loc1_ > 4)
         {
            _loc2_ = -50;
         }
         var _loc3_:slugObject = new cProjectileKnife(currentX + _loc2_,currentY - 50,GameMode.gameMode,directionToAngle(_loc1_,this));
         _loc3_.hostile = hostile;
         LevelUtils.levelOb(_loc3_);
         if(playerControlled && myHandler.enemyArray != null)
         {
            _loc4_ = 0;
            while(_loc4_ < myHandler.enemyArray.length)
            {
               PuffHandler.makePuff(myHandler.enemyArray[_loc4_].bodyParts[0],PuffHandler.PUFF_PANG,0,-30,1 + Math.random() / 10,1 + Math.random() / 10);
               _loc4_++;
            }
         }
         if(playerControlled)
         {
            SoundHandler.playSoundClass(sound_fryingpan);
         }
         myHandler.shotFired();
      }
      
      public function getProjectileClass() : Class
      {
         if(this is cSoldier && this.weapon_type == cProjectileGun.TYPE_BAZOOKA)
         {
            return cProjectileBazooka;
         }
         return cProjectileGun;
      }
      
      public function setWeapon(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:int = param1;
         if(this.hasWeapons[param1] || param2)
         {
            this.hasWeapons[param1] = true;
            if(this is cCar)
            {
               SlugScore.has_weapons[param1] = true;
               SlugScore.last_weapon = param1;
            }
            if(_loc3_ < 0)
            {
               _loc3_ = 0;
            }
            if(_loc3_ > cProjectileGun.NUM_PROJECTILE_TYPES - 1)
            {
               _loc3_ = cProjectileGun.NUM_PROJECTILE_TYPES - 1;
            }
            this.weapon_type = _loc3_;
            this.fire_delay = cProjectileGun.getRateForType(_loc3_);
         }
      }
      
      public function createGraphics() : void
      {
         setData(this.part_main,myBodyClip);
      }
   }
}
