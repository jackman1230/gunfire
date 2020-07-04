package objects
{
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   
   public class slugObject extends cObject
   {
      
      public static var showNames:Boolean = false;
       
      
      public var hostile:Boolean = false;
      
      public var neutral:Boolean = false;
      
      public var detail:Boolean = false;
      
      public var hitRect:Rectangle;
      
      public var dealsTouchDamage:int = -1;
      
      public var touchDamageDelay:int = -1;
      
      public var framesSinceDealtTouchDamage:int = -1;
      
      public var invulnerable:Boolean = false;
      
      public var slug_default_health:int = 100;
      
      public var slug_health:int = 0;
      
      public var slug_lives:int = 0;
      
      public var myBodyClip:MovieClip;
      
      public var framecount:int = 0;
      
      public var lifetime:int = -1;
      
      public var can_pickup:Boolean = false;
      
      public var can_be_picked_up:Boolean = false;
      
      public var is_camlock_enemy:Boolean = false;
      
      public var takesDamage:Boolean = false;
      
      public var take_damage_flash_counter:int = -1;
      
      public var use_auto_death_flashing:Boolean = true;
      
      public var alert_allies_on_damage:Boolean = false;
      
      public var time_to_stay_flagged:int = 30;
      
      public var scoreVal:int = 100;
      
      public var hitRectOffsetX:Number = 0;
      
      public var hitRectOffsetY:Number = 0;
      
      public var hitlist:Vector.<slugObject>;
      
      public function slugObject(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         this.hitRect = new Rectangle(0,-10,20,20);
         this.hitlist = new Vector.<slugObject>();
         super(param1,param2,param3,param4);
         slugCast = this;
         sluggable = true;
         this.getStats();
         if(World.currentLevel.inEditor)
         {
            showNames = true;
         }
      }
      
      public function getStats() : void
      {
         this.slug_health = this.slug_default_health;
      }
      
      public function amVisible() : Boolean
      {
         var _loc1_:Number = LevelUtils.highestX - 60;
         var _loc2_:Number = LevelUtils.highestX + global.gameWidth + 60;
         if(currentX > _loc1_ && currentX < _loc2_)
         {
            return true;
         }
         return false;
      }
      
      override public function subTick() : void
      {
         var _loc1_:int = 0;
         var _loc2_:slugObject = null;
         var _loc3_:cPickup = null;
         var _loc4_:Number = NaN;
         super.subTick();
         if(!World.currentLevel.inEditor)
         {
            if(this.amVisible())
            {
               this.slugtick();
            }
            else if(this is cProjectile)
            {
               flagged = true;
            }
            this.drawHitRect();
            if(this.framesSinceDealtTouchDamage == -1 && this.dealsTouchDamage > -1 && !flagged && flaggedTimer == -1)
            {
               if(this.checkHit())
               {
                  _loc1_ = 0;
                  while(_loc1_ < this.hitlist.length)
                  {
                     _loc2_ = this.hitlist[_loc1_];
                     this.framesSinceDealtTouchDamage = this.touchDamageDelay;
                     _loc2_.takeDamage(this,this.dealsTouchDamage);
                     this.dealtDamage(_loc2_,this.dealsTouchDamage);
                     _loc1_++;
                  }
                  if(this is cProjectile && this.touchDamageDelay == -1)
                  {
                     flaggedTimer = 0;
                     this.gotFlagged();
                  }
               }
            }
            if(this.can_pickup && !flagged && flaggedTimer == -1)
            {
               _loc3_ = this.checkPickup();
               if(_loc3_ != null)
               {
                  _loc3_.gotPickedUp(this);
               }
            }
            if(this.framesSinceDealtTouchDamage > -1)
            {
               this.framesSinceDealtTouchDamage = this.framesSinceDealtTouchDamage - 1;
            }
            if(flaggedTimer)
            {
               if(flaggedTimer % 3 == 0)
               {
                  if(this.myBodyClip != null)
                  {
                     if(this.use_auto_death_flashing)
                     {
                        this.myBodyClip.visible = !this.myBodyClip.visible;
                     }
                  }
               }
            }
            if(this.lifetime > -1 && this.framecount >= this.lifetime && !flagged && flaggedTimer == -1)
            {
               flagged = true;
               this.gotFlagged();
            }
            if(flaggedTimer == -1 && !flagged)
            {
               if(this.take_damage_flash_counter > -1)
               {
                  _loc4_ = 5;
                  this.myBodyClip.transform.colorTransform = new ColorTransform(1,1,1,1,this.take_damage_flash_counter * _loc4_,-this.take_damage_flash_counter * _loc4_,-this.take_damage_flash_counter * _loc4_);
                  this.take_damage_flash_counter = this.take_damage_flash_counter - 4;
                  if(this.take_damage_flash_counter == -1)
                  {
                  }
               }
            }
            this.framecount++;
         }
      }
      
      public function getDefaultEnemyHealth() : int
      {
         return World.currentLevel.myID * 12;
      }
      
      public function doScore() : void
      {
         ScoreHandler.addCoins(1,this.scoreVal);
      }
      
      public function gotFlagged() : void
      {
      }
      
      public function dealtDamage(param1:slugObject, param2:int) : void
      {
      }
      
      public function gcn() : String
      {
         return getQualifiedClassName(this);
      }
      
      public function takeDamage(param1:slugObject, param2:int) : void
      {
         var _loc3_:int = 0;
         if(!this.invulnerable)
         {
            _loc3_ = param2;
            if(playerControlled)
            {
               _loc3_ = _loc3_ / 10;
            }
            if(playerControlled && cCar.player_invincible)
            {
               _loc3_ = 0;
            }
            this.slug_health = this.slug_health - _loc3_;
            if(this.alert_allies_on_damage)
            {
               this.alertTeam(this.hostile || this.detail);
            }
            if(this.slug_health <= 0)
            {
               this.death();
            }
            else
            {
               this.doFlash();
            }
         }
      }
      
      public function doFlash() : void
      {
         this.take_damage_flash_counter = 20;
      }
      
      public function setLives(param1:int) : void
      {
         if(playerControlled)
         {
            this.slug_lives = param1;
         }
         else
         {
            this.slug_lives = param1;
         }
      }
      
      public function getLives() : int
      {
         if(playerControlled)
         {
            return this.slug_lives;
         }
         return this.slug_lives;
      }
      
      public function death() : void
      {
         this.slug_health = this.slug_default_health;
         this.setLives(this.getLives() - 1);
         if(this.getLives() > -1)
         {
            this.slug_health = this.slug_default_health;
            myHandler.playDie();
         }
         else if(playerControlled)
         {
            GameMode.failed = true;
         }
         else
         {
            flaggedTimer = this.time_to_stay_flagged;
         }
      }
      
      public function drawHitRect() : void
      {
         var _loc1_:Rectangle = this.getWorldHitRect();
      }
      
      public function slugtick() : void
      {
      }
      
      public function calcDistance(param1:cObject) : Number
      {
         if(param1 != null)
         {
            return param1.bodyParts[0].position.sub(bodyParts[0].position).length;
         }
         return -1;
      }
      
      public function getWorldHitRect() : Rectangle
      {
         var _loc1_:Number = currentX + this.hitRect.x + bodyParts[0].spriteOffsetX + this.hitRectOffsetX;
         var _loc2_:Number = currentY + this.hitRect.y + bodyParts[0].spriteOffsetY + this.hitRectOffsetY;
         var _loc3_:Number = this.hitRect.width;
         var _loc4_:Number = this.hitRect.height;
         return new Rectangle(_loc1_ - _loc3_ / 2,_loc2_ - _loc4_ / 2,_loc3_,_loc4_);
      }
      
      public function alertTeam(param1:Boolean = false) : void
      {
         var _loc3_:slugObject = null;
         var _loc2_:int = 0;
         while(_loc2_ < World.currentLevel.levelObjects.length)
         {
            if(World.currentLevel.levelObjects[_loc2_].sluggable)
            {
               _loc3_ = World.currentLevel.levelObjects[_loc2_] as slugObject;
               if(this.calcDistance(_loc3_) < 200)
               {
                  if(_loc3_ != this && (_loc3_.hostile == this.hostile || this.detail))
                  {
                     _loc3_.didHearAlert();
                  }
               }
            }
            _loc2_++;
         }
      }
      
      public function didHearAlert() : void
      {
      }
      
      public function checkHit() : Boolean
      {
         var _loc3_:slugObject = null;
         this.hitlist = new Vector.<slugObject>();
         var _loc1_:Rectangle = this.getWorldHitRect();
         var _loc2_:int = 0;
         while(_loc2_ < World.currentLevel.levelObjects.length)
         {
            if(World.currentLevel.levelObjects[_loc2_].sluggable)
            {
               _loc3_ = World.currentLevel.levelObjects[_loc2_] as slugObject;
               if(!_loc3_.neutral && (_loc3_.hostile != this.hostile || _loc3_.detail) && !_loc3_.invulnerable && _loc3_.flaggedTimer == -1)
               {
                  if(_loc3_.takesDamage && !(World.followObj as cCar).myHandler.playing_die_animation)
                  {
                     if(_loc1_.intersects(_loc3_.getWorldHitRect()))
                     {
                        this.hitlist.push(_loc3_);
                     }
                  }
               }
            }
            _loc2_++;
         }
         return this.hitlist.length > 0;
      }
      
      public function checkPickup() : cPickup
      {
         var _loc3_:cPickup = null;
         var _loc1_:Rectangle = this.getWorldHitRect();
         var _loc2_:int = 0;
         while(_loc2_ < World.currentLevel.levelObjects.length)
         {
            if(World.currentLevel.levelObjects[_loc2_].sluggable && World.currentLevel.levelObjects[_loc2_] is cPickup)
            {
               _loc3_ = World.currentLevel.levelObjects[_loc2_] as cPickup;
               if(_loc3_.can_be_picked_up && _loc3_.flaggedTimer == -1)
               {
                  if(_loc1_.intersects(_loc3_.getWorldHitRect()))
                  {
                     return _loc3_;
                  }
               }
            }
            _loc2_++;
         }
         return null;
      }
   }
}
