package
{
   import objects.cBiped;
   import objects.cObject;
   import objects.cProjectileGun;
   import objects.cSoldier;
   import objects.cSoldierIdle;
   import objects.cSoldierIdleRight;
   import objects.cSoldierPlatform;
   import objects.cTank;
   
   public class AICarHandler extends CarHandler
   {
      
      public static var clipPinned:Boolean = false;
       
      
      public var sClip:enemy01;
      
      public var crouchey_ai:Boolean = false;
      
      public var firstFrame:Boolean = true;
      
      public function AICarHandler(param1:GameMode, param2:cObject)
      {
         runSpeed = 2000;
         runSpeed_default = 2000;
         super(param1,param2);
         if(!myCar.isSwordsMan && !myCar.isTank && !myCar.isHitler)
         {
            this.sClip = (myCar as cSoldier).mySoliderClip;
            this.sClip.setHander(this);
            if(myCar.weapon_type == cProjectileGun.TYPE_BAZOOKA)
            {
               if(Math.random() > 0.5)
               {
                  this.crouchey_ai = true;
               }
            }
         }
         if(!myCar.flagged && myCar.flaggedTimer == -1)
         {
            if(World.currentLevel.goingLeft)
            {
               if(myCar.currentX > LevelUtils.highestX + 40 + global.gameWidth)
               {
                  myCar.flagged = true;
               }
            }
            else if(myCar.currentX < LevelUtils.highestX - 40)
            {
               myCar.flagged = true;
            }
            if(myCar.currentY > 480)
            {
               myCar.flagged = true;
            }
         }
      }
      
      public function toString() : String
      {
         return "[AICarHandler sClip=" + this.sClip + " clipPinned=" + clipPinned + " firstFrame=" + this.firstFrame + "]";
      }
      
      override public function doAI() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Boolean = false;
         control_rotRightDown = false;
         control_rotLeftDown = false;
         control_JumpDown = false;
         control_grenadeDown = false;
         control_shoot_down = false;
         control_knife_down = false;
         if(World.followObj != null && myCar.flaggedTimer == -1)
         {
            ai_player_currently_left = World.followObj.currentX < myCar.currentX;
            if(!ai_player_lock)
            {
               ai_player_lock_left = ai_player_currently_left;
            }
            else if(ai_player_currently_left != ai_player_lock_left)
            {
               ai_player_lock = false;
            }
            _loc2_ = 100 + ai_follow_distance_random_tolerance;
            if(myCar is cTank)
            {
               _loc2_ = 350;
            }
            _loc3_ = World.followObj.slugCast.calcDistance(myCar);
            _loc4_ = -1;
            if(!GameMode.failed && !GameMode.completed)
            {
               _loc4_ = World.followObj.slugCast.slug_health;
            }
            if(!ai_player_lock && !ai_notlooking)
            {
               if(_loc3_ > _loc2_ && !this.crouchey_ai)
               {
                  ai_need_to_move = true;
                  if(World.followObj.currentX < myCar.currentX)
                  {
                     control_rotLeftDown = true;
                  }
                  if(World.followObj.currentX > myCar.currentX)
                  {
                     control_rotRightDown = true;
                  }
               }
               else
               {
                  ai_need_to_move = false;
                  ai_jumps_attempted = false;
                  ai_follow_distance_random_tolerance = ai_follow_distance_random_tolerance + 150;
               }
            }
            else
            {
               ai_need_to_move = false;
            }
            if(got_platform)
            {
               if(myCar is cSoldierPlatform && Math.abs(myCar.currentX - startPoint.x) > myCar.wanderDistance)
               {
                  control_rotLeftDown = false;
                  control_rotRightDown = false;
                  ai_need_to_move = false;
               }
            }
            if(!ai_notlooking)
            {
               if(World.followObj.currentX < myCar.currentX)
               {
                  myCar.direction = cBiped.D_LEFT;
               }
               if(World.followObj.currentX > myCar.currentX)
               {
                  myCar.direction = cBiped.D_RIGHT;
               }
            }
            _loc5_ = this.getFacingLeft();
            myCar.myBodyClip.scaleX = (!!_loc5_?1:-1) * myCar.graphicScale;
         }
         if(ai_rotleftdown_count > 0 || ai_rotrightdown_count > 0)
         {
            if((ai_rotleftdown_count == 25 || ai_rotrightdown_count == 25) && !ai_jumps_attempted)
            {
               control_JumpDown = true;
               ai_jumps_attempted = true;
            }
            if(ai_rotleftdown_count == 50 || ai_rotrightdown_count == 50)
            {
               ai_player_lock = true;
            }
         }
         if(control_rotRightDown && ai_lastrotrightdown)
         {
            if(Math.abs(ai_blocker_start_x - myCar.currentX) < 1)
            {
               ai_rotrightdown_count++;
            }
            else
            {
               ai_rotrightdown_count = 0;
            }
         }
         else
         {
            ai_rotrightdown_count = 0;
         }
         if(control_rotLeftDown && ai_lastrotleftdown)
         {
            if(Math.abs(ai_blocker_start_x - myCar.currentX) < 1)
            {
               ai_rotleftdown_count++;
            }
            else
            {
               ai_rotleftdown_count = 0;
            }
         }
         else
         {
            ai_rotleftdown_count = 0;
         }
         control_shoot_down = false;
         control_grenadeDown = false;
         control_knife_down = false;
         if(ai_fire_suppression_temp == false && !ai_notlooking)
         {
            if(_loc4_ > 0)
            {
               if(!ai_need_to_move)
               {
                  if(groundConnection && jump_refire_count == -1)
                  {
                     if(myCar.flaggedTimer == -1 && !myCar.flagged)
                     {
                        if(_loc3_ < 20 && knife_refire_count == -1)
                        {
                           control_knife_down = true;
                        }
                        else if(myCar.fire_count == -1 && grenade_refire_count == -1)
                        {
                           if(Math.abs(World.followObj.currentY - myCar.currentY) < 160)
                           {
                              if(Math.random() > 0.95 && _loc3_ > 100 || myCar is cSoldierPlatform && Math.random() > 0.99)
                              {
                                 control_grenadeDown = true;
                              }
                              else
                              {
                                 control_shoot_down = true;
                              }
                           }
                           else if(Math.random() > 0.95)
                           {
                              control_grenadeDown = true;
                           }
                        }
                     }
                  }
               }
            }
         }
         myCar.facingLeft = myCar.direction > cBiped.D_DOWNLEFTEXTREME;
         ai_blocker_start_x = myCar.currentX;
         ai_lastrotrightdown = control_rotRightDown;
         ai_lastrotleftdown = control_rotLeftDown;
         if(ai_notlooking_undisturbed)
         {
            if(enemyNearMe())
            {
               ai_notlooking_undisturbed = false;
            }
         }
      }
      
      public function getFacingLeft() : Boolean
      {
         return myCar.direction > cBiped.D_PERFECT_DOWN;
      }
      
      public function set_ai(param1:String, param2:Boolean = false) : void
      {
         this.sClip.gotoAndStop(param1);
      }
      
      override public function doAnims() : void
      {
         var _loc1_:* = false;
         var _loc2_:* = false;
         var _loc3_:* = false;
         var _loc4_:* = false;
         var _loc5_:* = false;
         var _loc6_:* = false;
         var _loc7_:* = undefined;
         if(!clipPinned)
         {
            clipPinned = true;
         }
         anim_attacking = control_shoot_down || control_grenadeDown || control_knife_down;
         if(!playerControlled)
         {
            if(!playing_die_animation)
            {
               if(!crouching)
               {
                  anim_runDir = 0;
                  if(control_rotRightDown)
                  {
                     anim_runDir = 1;
                  }
                  if(control_rotLeftDown)
                  {
                     anim_runDir = 2;
                  }
                  _loc1_ = anim_runDir != last_rundir;
                  _loc2_ = lastAD != myCar.direction;
                  _loc3_ = lastAT != anim_attacking;
                  _loc4_ = got_air != last_air;
                  _loc5_ = ai_notlooking != last_notlooking;
                  _loc6_ = ai_notlooking_undisturbed != last_ai_notlooking_undisturbed;
                  myCar.fire_delay = 40;
                  _loc7_ = _loc3_ || _loc2_ && !got_air || myCar.fire_count == 0;
                  if(!ai_notlooking_undisturbed && _loc6_)
                  {
                     ai_notlooking_counter = 6 + Math.random() * 5;
                     this.set_ai("shocked",true);
                     _loc7_ = false;
                  }
                  if(ai_notlooking_counter > -1)
                  {
                     _loc7_ = false;
                     ai_notlooking_counter--;
                     if(ai_notlooking_counter == -1)
                     {
                        ai_notlooking = false;
                     }
                  }
                  if(this.firstFrame)
                  {
                     if(myCar is cSoldierIdle)
                     {
                        if(Math.random() > 0.5)
                        {
                           this.set_ai("talk01",true);
                        }
                        else
                        {
                           this.set_ai("stand1",true);
                        }
                     }
                     else if(myCar is cSoldierIdleRight)
                     {
                        if(Math.random() > 0.5)
                        {
                           this.set_ai("talk02",true);
                        }
                        else
                        {
                           this.set_ai("talk03",true);
                        }
                     }
                     else
                     {
                        this.set_ai(this.getDefaultStand(),true);
                     }
                  }
                  if(!ai_notlooking)
                  {
                     if(!got_air && _loc1_)
                     {
                        if(anim_runDir > 0)
                        {
                           this.set_ai(this.getDefaultRun(),true);
                        }
                        else
                        {
                           this.set_ai(this.getDefaultStand(),true);
                        }
                     }
                     if(!anim_attacking && got_air && _loc4_)
                     {
                        _loc7_ = false;
                        this.set_ai(this.getDefaultRun(),true);
                     }
                     if(!anim_attacking && groundConnection && _loc4_)
                     {
                        _loc7_ = false;
                        this.set_ai(this.getDefaultStand(),true);
                     }
                     if(_loc7_ && anim_attacking)
                     {
                        if(control_grenadeDown)
                        {
                           this.set_ai("shoot4",true);
                        }
                        else if(control_knife_down)
                        {
                           if(Math.random() > 0.5)
                           {
                              this.set_ai("attack",true);
                           }
                           else
                           {
                              this.set_ai("attack",true);
                           }
                        }
                        else
                        {
                           this.set_ai(this.getDefaultShoot(),true);
                        }
                     }
                  }
                  if((myCar.flagged || myCar.flaggedTimer > -1) && !last_flagged)
                  {
                     this.triggerDie();
                  }
               }
            }
         }
         this.firstFrame = false;
      }
      
      public function triggerDie() : void
      {
         var _loc1_:Number = Math.random();
         if(_loc1_ > 0.66)
         {
            this.set_ai("die1",true);
         }
         else if(_loc1_ > 0.33)
         {
            this.set_ai("die2",true);
         }
         else
         {
            this.set_ai("die3",true);
         }
         playing_die_animation = true;
      }
      
      override public function getDefaultShoot() : String
      {
         var _loc1_:Number = NaN;
         if(myCar != null)
         {
            if(myCar.weapon_type == cProjectileGun.TYPE_RIFLE)
            {
               return "shoot2";
            }
            if(myCar.weapon_type == cProjectileGun.TYPE_BAZOOKA)
            {
               if(!this.crouchey_ai)
               {
                  return "shoot3";
               }
               return "shoot5";
            }
            _loc1_ = Math.random();
            if(_loc1_ > 0.66)
            {
               return "shoot1";
            }
            if(_loc1_ > 0.33)
            {
               return "shoot4";
            }
            return "shoot4";
         }
         return "shoot2";
      }
      
      override public function getDefaultStand() : String
      {
         var _loc1_:Number = NaN;
         if(myCar != null)
         {
            if(myCar.weapon_type == cProjectileGun.TYPE_RIFLE)
            {
               return "stand2";
            }
            if(myCar.weapon_type == cProjectileGun.TYPE_BAZOOKA)
            {
               if(!this.crouchey_ai)
               {
                  return "stand3";
               }
               return "stand5";
            }
            _loc1_ = Math.random();
            if(_loc1_ > 0.66)
            {
               return "stand1";
            }
            if(_loc1_ > 0.33)
            {
               return "stand4";
            }
            return "stand6";
         }
         return "stand2";
      }
      
      override public function getDefaultRun() : String
      {
         var _loc1_:Number = NaN;
         if(myCar != null)
         {
            if(myCar.weapon_type == cProjectileGun.TYPE_RIFLE)
            {
               return "run2";
            }
            if(myCar.weapon_type == cProjectileGun.TYPE_BAZOOKA)
            {
               if(!this.crouchey_ai)
               {
                  return "run3";
               }
               return "run5";
            }
            _loc1_ = Math.random();
            if(_loc1_ > 0.66)
            {
               return "run1";
            }
            if(_loc1_ > 0.33)
            {
               return "run4";
            }
            return "run6";
         }
         return "run2";
      }
      
      override public function spriteStandCall() : void
      {
         this.set_ai(this.getDefaultStand(),true);
      }
      
      override public function spriteGrenadeCall() : void
      {
         super.spriteGrenadeCall();
         if(myCar != null)
         {
            myCar.doGrenade();
         }
      }
      
      override public function spriteShootCall() : void
      {
         super.spriteShootCall();
         if(myCar != null)
         {
            myCar.doFire();
         }
      }
      
      override public function spriteAttackCall() : void
      {
         super.spriteAttackCall();
      }
   }
}
