package
{
   import flash.display.MovieClip;
   import nape.geom.Vec2;
   import objects.cBiped;
   import objects.cCar;
   import objects.cObject;
   import objects.cProjectileGun;
   import objects.cSoldierIdle;
   import objects.cSoldierIdleRight;
   import objects.slugObject;
   
   public class CarHandler
   {
      
      public static var autoControls:Boolean = false;
      
      public static var ai_fire_suppression_temp:Boolean = false;
       
      
      public var gMode:GameMode = null;
      
      public var myCar:cBiped = null;
      
      public var playerControlled:Boolean = true;
      
      public var isFollowObject:Boolean = false;
      
      public var frameCount:int = 0;
      
      public var playing_die_animation:Boolean = false;
      
      public var control_rotLeftDown:Boolean = false;
      
      public var control_rotRightDown:Boolean = false;
      
      public var control_JumpDown:Boolean = false;
      
      public var control_duckDown:Boolean = false;
      
      public var control_grenadeDown:Boolean = false;
      
      public var control_knife_down:Boolean = false;
      
      public var has_control:Boolean = false;
      
      public var crouching:Boolean = false;
      
      public var control_shoot_down:Boolean = false;
      
      public var grenade_refire_delay:int = 25;
      
      public var grenade_refire_count:int = -1;
      
      public var knife_refire_delay:int = 25;
      
      public var knife_refire_count:int = -1;
      
      public var groundConnection:Boolean = false;
      
      public var runSpeed:Number = 4000;
      
      public var runSpeed_default:Number = 4000;
      
      public var jumpForce:Number = 10000;
      
      public var jump_refire_count:int = -1;
      
      public var ai_notlooking:Boolean = false;
      
      public var ai_notlooking_undisturbed:Boolean = false;
      
      public var ai_fire_delay_modifier:int = 1;
      
      public var ai_follow_distance_random_tolerance:int = 0;
      
      public var ai_lastrotrightdown:Boolean = false;
      
      public var ai_lastrotleftdown:Boolean = false;
      
      public var ai_rotrightdown_count:int = 0;
      
      public var ai_rotleftdown_count:int = 0;
      
      public var ai_blocker_start_x:Number = 0;
      
      public var ai_player_currently_left:Boolean = false;
      
      public var ai_player_lock_left:Boolean = false;
      
      public var ai_player_lock:Boolean = false;
      
      public var ai_jumps_attempted:Boolean = false;
      
      public var ai_need_to_move:Boolean = false;
      
      public var startPoint:Vec2;
      
      public var got_platform:Boolean = true;
      
      public var airCount:int = 0;
      
      public var got_air:Boolean = false;
      
      public var lastGroundPos:Vec2;
      
      public var anim_health:int = 0;
      
      public var anim_attacking:Boolean = false;
      
      public var anim_runDir:int = 0;
      
      public var lastAD:int = 0;
      
      public var last_rundir:int = 0;
      
      public var last_air:Boolean = false;
      
      public var lastAT:Boolean = false;
      
      public var last_notlooking:Boolean = false;
      
      public var last_ai_notlooking_undisturbed:Boolean = false;
      
      public var ai_notlooking_counter:int = -1;
      
      public var last_flagged:Boolean = false;
      
      public var last_health:int = 0;
      
      public var last_crouching:Boolean = false;
      
      public var enemyArray:Vector.<slugObject>;
      
      public var time_since_fire:int = 0;
      
      public function CarHandler(param1:GameMode, param2:cObject)
      {
         this.startPoint = new Vec2();
         super();
         this.gMode = param1;
         if(param2)
         {
            this.myCar = param2 as cBiped;
         }
         this.playerControlled = this.myCar.playerControlled;
         if(!this.playerControlled)
         {
            this.ai_fire_delay_modifier = 2;
         }
         this.ai_follow_distance_random_tolerance = this.ai_follow_distance_random_tolerance + Math.floor(Math.random() * 147);
         this.ai_notlooking = (Math.random() > 0.9 || this.myCar is cSoldierIdle || this.myCar is cSoldierIdleRight) && this.myCar.can_notlook;
         this.ai_notlooking_undisturbed = this.ai_notlooking;
         if(this.ai_notlooking)
         {
            this.myCar.direction = cBiped.D_RIGHT;
         }
         this.startPoint = new Vec2(this.myCar.currentX,this.myCar.currentY);
      }
      
      public function spriteGrenadeCall() : void
      {
      }
      
      public function spriteAttackCall() : void
      {
      }
      
      public function spriteStandCall() : void
      {
      }
      
      public function spriteShootCall() : void
      {
      }
      
      public function tick(param1:int = -1) : *
      {
         if(param1 > -1)
         {
            this.frameCount = param1;
         }
         if(this.ensureConnection())
         {
            if(this.playerControlled)
            {
               this.getControls();
            }
            else if(this.myCar.amVisible())
            {
               this.doAI();
            }
            this.getGrounded();
            this.applyControls();
            if(!(this.playing_die_animation && this.playerControlled))
            {
               this.doAnims();
            }
            this.updateLasts();
            if(this.playerControlled)
            {
               this.drawDebug();
            }
         }
         this.time_since_fire++;
         this.frameCount++;
      }
      
      public function getGrounded() : void
      {
         this.groundConnection = QueryHandler.getGroundConnection(this.myCar.part_main,false);
         if(!this.groundConnection)
         {
            this.airCount++;
         }
         else
         {
            this.airCount = 0;
         }
         this.got_air = this.airCount > 2;
         if(this.airCount > 8)
         {
            this.got_platform = false;
         }
         if(this.airCount < 1)
         {
            this.lastGroundPos = new Vec2(this.myCar.currentX,this.myCar.currentY);
         }
      }
      
      public function drawDebug() : *
      {
         if(this.myCar != null && this.myCar == World.followObj)
         {
            this.gMode.dbgText.drawString("g " + this.groundConnection);
         }
      }
      
      public function playDie() : void
      {
         this.myCar.invulnerable = true;
         cCar.player_invincible = true;
         this.playing_die_animation = true;
         this.setUp("die01",true,true);
         this.setDown("nothing1",false);
      }
      
      public function unDie() : void
      {
         this.myCar.invulnerable = false;
         cCar.player_invincible = false;
         this.playing_die_animation = false;
         this.setUp(this.getDefaultStand(),true,true);
         if(this.control_rotLeftDown || this.control_rotRightDown)
         {
            this.setDown("stand_run",true);
         }
         else
         {
            this.setDown("stand",true);
         }
      }
      
      public function doAnims() : void
      {
         var _loc1_:* = false;
         var _loc2_:* = false;
         var _loc3_:* = false;
         var _loc4_:* = false;
         var _loc5_:* = false;
         var _loc6_:* = undefined;
         this.anim_attacking = this.control_shoot_down || this.control_grenadeDown || this.control_knife_down;
         if(!this.playing_die_animation)
         {
            if(this.playerControlled)
            {
               this.anim_runDir = 0;
               if(this.control_rotRightDown)
               {
                  this.anim_runDir = 1;
               }
               if(this.control_rotLeftDown)
               {
                  this.anim_runDir = 2;
               }
               _loc1_ = this.anim_runDir != this.last_rundir;
               _loc2_ = this.lastAD != this.myCar.direction;
               _loc3_ = this.lastAT != this.anim_attacking;
               _loc4_ = this.got_air != this.last_air;
               _loc5_ = this.crouching != this.last_crouching;
               _loc6_ = _loc3_ || _loc2_ && !this.got_air || this.myCar.fire_count == 0;
               if(_loc1_ || _loc5_ || _loc4_)
               {
                  if(this.groundConnection)
                  {
                     if(this.anim_runDir > 0)
                     {
                        if(this.crouching)
                        {
                           this.setDown("crouch_run",true);
                        }
                        else
                        {
                           this.setDown("stand_run",true);
                        }
                     }
                     else if(this.crouching)
                     {
                        this.setDown("crouch",true);
                     }
                     else
                     {
                        this.setDown("stand",true);
                     }
                  }
                  else
                  {
                     this.setDown("jump",true);
                  }
                  if(!this.anim_attacking)
                  {
                     this.setUp(this.getDefaultRun(),true,true);
                  }
                  _loc6_ = false;
               }
               if(this.crouching)
               {
                  if(_loc6_)
                  {
                     cCar.currentPlayerClip.up.rotation = 180;
                     if(this.control_grenadeDown)
                     {
                        if(this.myCar.weapon_type == cProjectileGun.TYPE_PISTOL)
                        {
                           this.setUp("pistol_crouch_bomb",_loc6_,this.anim_attacking);
                        }
                        else
                        {
                           this.setUp("machinegun_crouch_bomb",_loc6_,this.anim_attacking);
                        }
                     }
                     else if(this.control_knife_down)
                     {
                        this.setUp("attack_crouch1",_loc6_,this.anim_attacking);
                     }
                     else if(this.control_shoot_down)
                     {
                        if(this.myCar.weapon_type == cProjectileGun.TYPE_PISTOL)
                        {
                           this.setUp("pistol_crouch_single",_loc6_,this.anim_attacking);
                        }
                        else if(this.myCar.weapon_type == cProjectileGun.TYPE_MACHINEGUN)
                        {
                           this.setUp("machinegun_crouch_running",_loc6_,this.anim_attacking);
                        }
                        else
                        {
                           this.setUp("machinegun_crouch_single",_loc6_,this.anim_attacking);
                        }
                     }
                     else if(this.myCar.weapon_type == cProjectileGun.TYPE_PISTOL)
                     {
                        this.setUp("pistol_crouch",_loc6_,this.anim_attacking);
                     }
                     else
                     {
                        this.setUp("machinegun_crouch",_loc6_,true);
                     }
                  }
               }
               if(!this.crouching)
               {
                  if(_loc6_)
                  {
                     if(this.control_grenadeDown)
                     {
                        if(this.myCar.weapon_type == cProjectileGun.TYPE_PISTOL)
                        {
                           this.setUp("pistol_stand_bomb",true,true);
                        }
                        else
                        {
                           this.setUp("machinegun_stand_bomb",true,true);
                        }
                     }
                     else if(this.control_knife_down)
                     {
                        if(Math.random() > 0.5)
                        {
                           this.setUp("attack_stand1",true,true);
                        }
                        else
                        {
                           this.setUp("attack_stand2",true,true);
                        }
                     }
                     else if(this.myCar.weapon_type == cProjectileGun.TYPE_PISTOL)
                     {
                        if(this.myCar.direction == cBiped.D_UPLEFTEXTREME || this.myCar.direction == cBiped.D_UPRIGHTEXTREME)
                        {
                           this.setUE("pistol_up_single","pistol_lookup",_loc6_,this.anim_attacking);
                        }
                        if(this.myCar.direction == cBiped.D_UPLEFT || this.myCar.direction == cBiped.D_UPRIGHT)
                        {
                           this.setUE("pistol_up_single","pistol_lookup",_loc6_,this.anim_attacking);
                        }
                        if(this.myCar.direction == cBiped.D_NEWLEFT || this.myCar.direction == cBiped.D_NEWRIGHT)
                        {
                           this.setUE("pistol_straight_single","pistol_stand",_loc6_,this.anim_attacking);
                        }
                        if(this.myCar.direction == cBiped.D_LEFT || this.myCar.direction == cBiped.D_RIGHT)
                        {
                           this.setUE("pistol_straight_single","pistol_stand",_loc6_,this.anim_attacking);
                        }
                        if(this.myCar.direction == cBiped.D_NEWDOWNLEFT || this.myCar.direction == cBiped.D_NEWDOWNRIGHT)
                        {
                           this.setUE("pistol_straight_single","pistol_stand",_loc6_,this.anim_attacking);
                        }
                        if(this.myCar.direction == cBiped.D_DOWNLEFT || this.myCar.direction == cBiped.D_DOWNRIGHT)
                        {
                           this.setUE("pistol_straight_single","pistol_stand",_loc6_,this.anim_attacking);
                        }
                        if(this.myCar.direction == cBiped.D_DOWNLEFTEXTREME || this.myCar.direction == cBiped.D_DOWNRIGHTEXTREME)
                        {
                           this.setUE("pistol_down_single","pistol_down",_loc6_,this.anim_attacking);
                        }
                        if(this.myCar.direction == cBiped.D_UPRIGHT || this.myCar.direction == cBiped.D_UPLEFT)
                        {
                           cCar.currentPlayerClip.up.rotation = 180 + 20;
                        }
                        else if(this.myCar.direction == cBiped.D_NEWRIGHT || this.myCar.direction == cBiped.D_NEWLEFT)
                        {
                           cCar.currentPlayerClip.up.rotation = 180 - 20;
                        }
                        else if(this.myCar.direction == cBiped.D_NEWDOWNRIGHT || this.myCar.direction == cBiped.D_NEWDOWNLEFT)
                        {
                           cCar.currentPlayerClip.up.rotation = 180 + 15;
                        }
                        else if(this.myCar.direction == cBiped.D_DOWNRIGHT || this.myCar.direction == cBiped.D_DOWNLEFT)
                        {
                           cCar.currentPlayerClip.up.rotation = 180 + 35;
                        }
                        else
                        {
                           cCar.currentPlayerClip.up.rotation = 180;
                        }
                     }
                     else if(this.myCar.weapon_type == cProjectileGun.TYPE_MACHINEGUN)
                     {
                        if(this.myCar.direction == cBiped.D_UPLEFTEXTREME || this.myCar.direction == cBiped.D_UPRIGHTEXTREME)
                        {
                           this.setUE("machinegun_up_running","machinegun_lookup",_loc6_,this.anim_attacking);
                        }
                        if(this.myCar.direction == cBiped.D_UPLEFT || this.myCar.direction == cBiped.D_UPRIGHT)
                        {
                           this.setUE("machinegun_up_running","machinegun_lookup",_loc6_,this.anim_attacking);
                        }
                        if(this.myCar.direction == cBiped.D_NEWLEFT || this.myCar.direction == cBiped.D_NEWRIGHT)
                        {
                           this.setUE("machinegun_straight_running","machinegun_stand",_loc6_,this.anim_attacking);
                        }
                        if(this.myCar.direction == cBiped.D_LEFT || this.myCar.direction == cBiped.D_RIGHT)
                        {
                           this.setUE("machinegun_straight_running","machinegun_stand",_loc6_,this.anim_attacking);
                        }
                        if(this.myCar.direction == cBiped.D_NEWDOWNLEFT || this.myCar.direction == cBiped.D_NEWDOWNRIGHT)
                        {
                           this.setUE("machinegun_straight_running","machinegun_stand",_loc6_,this.anim_attacking);
                        }
                        if(this.myCar.direction == cBiped.D_DOWNLEFT || this.myCar.direction == cBiped.D_DOWNRIGHT)
                        {
                           this.setUE("machinegun_straight_running","machinegun_stand",_loc6_,this.anim_attacking);
                        }
                        if(this.myCar.direction == cBiped.D_DOWNLEFTEXTREME || this.myCar.direction == cBiped.D_DOWNRIGHTEXTREME)
                        {
                           this.setUE("machinegun_down_running","machinegun_down",_loc6_,this.anim_attacking);
                        }
                        if(this.myCar.direction == cBiped.D_UPRIGHTEXTREME || this.myCar.direction == cBiped.D_UPLEFTEXTREME)
                        {
                           cCar.currentPlayerClip.up.rotation = 180 + 20 + 0;
                        }
                        else if(this.myCar.direction == cBiped.D_UPRIGHT || this.myCar.direction == cBiped.D_UPLEFT)
                        {
                           cCar.currentPlayerClip.up.rotation = 180 + 46;
                        }
                        else if(this.myCar.direction == cBiped.D_NEWRIGHT || this.myCar.direction == cBiped.D_NEWLEFT)
                        {
                           cCar.currentPlayerClip.up.rotation = 180 - 20;
                        }
                        else if(this.myCar.direction == cBiped.D_NEWDOWNLEFT || this.myCar.direction == cBiped.D_NEWDOWNRIGHT)
                        {
                           cCar.currentPlayerClip.up.rotation = 180 + 15;
                        }
                        else if(this.myCar.direction == cBiped.D_DOWNLEFT || this.myCar.direction == cBiped.D_DOWNRIGHT)
                        {
                           cCar.currentPlayerClip.up.rotation = 180 + 45;
                        }
                        else
                        {
                           cCar.currentPlayerClip.up.rotation = 180;
                        }
                     }
                     else
                     {
                        if(this.myCar.direction == cBiped.D_UPLEFTEXTREME || this.myCar.direction == cBiped.D_UPRIGHTEXTREME)
                        {
                           this.setUE("machinegun_up_single","machinegun_lookup",_loc6_,this.anim_attacking);
                        }
                        if(this.myCar.direction == cBiped.D_UPLEFT || this.myCar.direction == cBiped.D_UPRIGHT)
                        {
                           this.setUE("machinegun_up_single","machinegun_lookup",_loc6_,this.anim_attacking);
                        }
                        if(this.myCar.direction == cBiped.D_NEWLEFT || this.myCar.direction == cBiped.D_NEWRIGHT)
                        {
                           this.setUE("machinegun_straight_single","machinegun_stand",_loc6_,this.anim_attacking);
                        }
                        if(this.myCar.direction == cBiped.D_LEFT || this.myCar.direction == cBiped.D_RIGHT)
                        {
                           this.setUE("machinegun_straight_single","machinegun_stand",_loc6_,this.anim_attacking);
                        }
                        if(this.myCar.direction == cBiped.D_NEWDOWNLEFT || this.myCar.direction == cBiped.D_NEWDOWNRIGHT)
                        {
                           this.setUE("machinegun_straight_single","machinegun_stand",_loc6_,this.anim_attacking);
                        }
                        if(this.myCar.direction == cBiped.D_DOWNLEFT || this.myCar.direction == cBiped.D_DOWNRIGHT)
                        {
                           this.setUE("machinegun_straight_single","machinegun_stand",_loc6_,this.anim_attacking);
                        }
                        if(this.myCar.direction == cBiped.D_DOWNLEFTEXTREME || this.myCar.direction == cBiped.D_DOWNRIGHTEXTREME)
                        {
                           this.setUE("machinegun_down_single","machinegun_down",_loc6_,this.anim_attacking);
                        }
                        if(this.myCar.direction == cBiped.D_UPRIGHTEXTREME || this.myCar.direction == cBiped.D_UPLEFTEXTREME)
                        {
                           cCar.currentPlayerClip.up.rotation = 180 + 20 + 0;
                        }
                        else if(this.myCar.direction == cBiped.D_UPRIGHT || this.myCar.direction == cBiped.D_UPLEFT)
                        {
                           cCar.currentPlayerClip.up.rotation = 180 + 46;
                        }
                        else if(this.myCar.direction == cBiped.D_NEWRIGHT || this.myCar.direction == cBiped.D_NEWLEFT)
                        {
                           cCar.currentPlayerClip.up.rotation = 180 - 20;
                        }
                        else if(this.myCar.direction == cBiped.D_NEWDOWNLEFT || this.myCar.direction == cBiped.D_NEWDOWNRIGHT)
                        {
                           cCar.currentPlayerClip.up.rotation = 180 + 15;
                        }
                        else if(this.myCar.direction == cBiped.D_DOWNLEFT || this.myCar.direction == cBiped.D_DOWNRIGHT)
                        {
                           cCar.currentPlayerClip.up.rotation = 180 + 45;
                        }
                        else
                        {
                           cCar.currentPlayerClip.up.rotation = 180;
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function updateLasts() : *
      {
         this.lastAD = this.myCar.direction;
         this.lastAT = this.anim_attacking;
         this.last_rundir = this.anim_runDir;
         this.last_air = this.got_air;
         this.last_notlooking = this.ai_notlooking;
         this.last_ai_notlooking_undisturbed = this.ai_notlooking_undisturbed;
         this.last_flagged = this.myCar.flagged || this.myCar.flaggedTimer > -1;
         this.last_health = this.anim_health;
         this.last_crouching = this.crouching;
      }
      
      public function setDown(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         if(!param2)
         {
            if(cCar.currentPlayerClip != null && cCar.currentPlayerClip.down != null)
            {
               cCar.currentPlayerClip.down.gotoAndStop(param1);
            }
            if(cCar.currentPlayerClip.down.numChildren > 0)
            {
               _loc3_ = 0;
               while(_loc3_ < cCar.currentPlayerClip.down.numChildren)
               {
                  (cCar.currentPlayerClip.down.getChildAt(_loc3_) as MovieClip).gotoAndStop(0);
                  _loc3_++;
               }
            }
         }
         else
         {
            if(cCar.currentPlayerClip != null && cCar.currentPlayerClip.down != null)
            {
               cCar.currentPlayerClip.down.gotoAndStop(param1);
            }
            if(cCar.currentPlayerClip.down.numChildren > 0)
            {
               _loc3_ = 0;
               while(_loc3_ < cCar.currentPlayerClip.down.numChildren)
               {
                  (cCar.currentPlayerClip.down.getChildAt(_loc3_) as MovieClip).play();
                  _loc3_++;
               }
            }
         }
      }
      
      public function setUE(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false) : *
      {
         if(!param4)
         {
            this.setUp(param2,true,true);
         }
         else
         {
            this.setUp(param1,true,true);
         }
      }
      
      public function setUp(param1:String, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc4_:int = 0;
         if(param2)
         {
            if(!param3)
            {
               if(cCar.currentPlayerClip != null && cCar.currentPlayerClip.up != null)
               {
                  cCar.currentPlayerClip.up.gotoAndStop(param1);
               }
               if(cCar.currentPlayerClip.up.numChildren > 0)
               {
                  _loc4_ = 0;
                  while(_loc4_ < cCar.currentPlayerClip.up.numChildren)
                  {
                     (cCar.currentPlayerClip.up.getChildAt(_loc4_) as MovieClip).gotoAndStop(0);
                     _loc4_++;
                  }
               }
            }
            else
            {
               if(cCar.currentPlayerClip != null && cCar.currentPlayerClip.up != null)
               {
                  cCar.currentPlayerClip.up.gotoAndStop(param1);
               }
               if(cCar.currentPlayerClip.up.numChildren > 0)
               {
                  _loc4_ = 0;
                  while(_loc4_ < cCar.currentPlayerClip.up.numChildren)
                  {
                     (cCar.currentPlayerClip.up.getChildAt(_loc4_) as MovieClip).play();
                     _loc4_++;
                  }
               }
            }
         }
      }
      
      public function applyControls() : void
      {
         this.myCar.part_main.angularVel = 0;
         this.myCar.part_main.rotation = 0;
         if(this.control_rotRightDown)
         {
            this.myCar.part_main.applyWorldForce(new Vec2(this.runSpeed,0));
         }
         if(this.control_rotLeftDown)
         {
            this.myCar.part_main.applyWorldForce(new Vec2(-this.runSpeed,0));
         }
         if(GameMode.gameMode.frameCount > 10 && this.playerControlled)
         {
            if(this.myCar.bodyParts[0].position.x > LevelUtils.highestX + global.gameWidth)
            {
               this.myCar.bodyParts[0].position = new Vec2(LevelUtils.highestX + global.gameWidth,this.myCar.bodyParts[0].position.y);
            }
            if(this.myCar.bodyParts[0].position.x <= LevelUtils.highestX)
            {
               this.myCar.bodyParts[0].position = new Vec2(LevelUtils.highestX,this.myCar.bodyParts[0].position.y);
            }
         }
         if(this.jump_refire_count > -1)
         {
            this.jump_refire_count--;
         }
         else if(this.control_JumpDown && this.groundConnection)
         {
            this.myCar.part_main.applyWorldForce(new Vec2(0,-this.jumpForce));
            this.jump_refire_count = 20;
         }
         this.myCar.part_main.gravMassScale = 1;
         if(this.control_rotRightDown || this.control_rotLeftDown)
         {
            this.myCar.part_main.shapes.at(0).material.dynamicFriction = 0;
         }
         else
         {
            this.myCar.part_main.shapes.at(0).material.dynamicFriction = 100;
            if(this.groundConnection)
            {
               this.myCar.part_main.gravMassScale = 0;
               this.myCar.part_main.velocity.muleq(0.1);
            }
         }
         if(this.myCar.part_main.velocity.x > 40)
         {
            this.myCar.part_main.velocity.x = 40;
         }
         if(this.myCar.part_main.velocity.x < -40)
         {
            this.myCar.part_main.velocity.x = -40;
         }
         var _loc2_:Boolean = this.grenade_refire_count == -1 && this.knife_refire_count == -1 && this.myCar.fire_count == -1;
         if(this.myCar.fire_count > -1)
         {
            this.myCar.fire_count--;
         }
         if(this.control_shoot_down && _loc2_)
         {
            if(this.playerControlled)
            {
               this.myCar.doFire();
            }
            this.myCar.fire_count = this.myCar.fire_delay * this.ai_fire_delay_modifier;
            GameMode.mousePendingFlag = false;
         }
         if(this.knife_refire_count > -1)
         {
            this.knife_refire_count = this.knife_refire_count - 1;
         }
         if(this.control_knife_down && _loc2_)
         {
            this.myCar.doKnife();
            this.knife_refire_count = this.knife_refire_delay * this.ai_fire_delay_modifier;
            GameMode.mousePendingFlag = false;
         }
         if(this.grenade_refire_count > -1)
         {
            this.grenade_refire_count = this.grenade_refire_count - 1;
         }
         if(this.control_grenadeDown && _loc2_)
         {
            if(this.playerControlled)
            {
               this.myCar.doGrenade();
            }
            this.grenade_refire_count = this.grenade_refire_delay * this.ai_fire_delay_modifier;
            GameMode.mousePendingFlag = false;
         }
      }
      
      public function getDefaultShoot() : String
      {
         return "";
      }
      
      public function getDefaultJump() : String
      {
         if(this.myCar.weapon_type != cProjectileGun.TYPE_PISTOL)
         {
            return "machinegun_jump";
         }
         return "pistol_jump";
      }
      
      public function getDefaultRun() : String
      {
         return this.getDefaultStand();
      }
      
      public function getDefaultStand() : String
      {
         if(this.myCar.weapon_type != cProjectileGun.TYPE_PISTOL)
         {
            if(this.crouching)
            {
               return "machinegun_crouch";
            }
            return "machinegun_stand";
         }
         if(this.crouching)
         {
            return "pistol_crouch";
         }
         return "pistol_stand";
      }
      
      public function stopThrowing() : void
      {
         this.setUp(this.getDefaultStand(),true,true);
      }
      
      public function enemyNearMe() : Boolean
      {
         var _loc1_:cObject = null;
         this.enemyArray = new Vector.<slugObject>();
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         while(_loc3_ < World.currentLevel.levelObjects.length)
         {
            _loc1_ = World.currentLevel.levelObjects[_loc3_];
            if(_loc1_.sluggable && _loc1_ != this.myCar)
            {
               if(_loc1_.slugCast.hostile != this.myCar.hostile && _loc1_.slugCast.takesDamage)
               {
                  if(this.playerControlled && _loc1_.slugCast.is_camlock_enemy || !this.playerControlled)
                  {
                     if(Math.abs(_loc1_.currentX - this.myCar.currentX) < 60)
                     {
                        if(Math.abs(_loc1_.currentY - this.myCar.currentY) < 40)
                        {
                           if(_loc1_.slugCast.slug_health > 0)
                           {
                              this.enemyArray.push(_loc1_.slugCast);
                              _loc2_ = true;
                           }
                        }
                     }
                  }
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function doAI() : void
      {
      }
      
      public function getControls() : void
      {
         var _loc4_:Boolean = false;
         this.isFollowObject = this.myCar == World.followObj;
         this.has_control = GameMode.control && !this.playing_die_animation;
         if(this.has_control)
         {
            this.control_JumpDown = this.gMode.accelDown;
            this.control_duckDown = this.gMode.revDown;
            this.control_shoot_down = this.playerControlled && (GameMode.mouseIsDown || GameMode.mousePendingFlag || this.gMode.spaceDown) && !this.enemyNearMe();
            this.control_knife_down = this.playerControlled && (GameMode.mouseIsDown || GameMode.mousePendingFlag) && this.enemyNearMe() || this.gMode.xDown;
            this.control_grenadeDown = (this.gMode.qDown || this.gMode.eDown) && SlugScore.hasEnoughBullets(cProjectileGun.TYPE_GRENADE);
            _loc4_ = this.control_shoot_down || this.control_knife_down || this.control_grenadeDown;
            this.control_rotRightDown = this.gMode.rotRightDown;
            this.control_rotLeftDown = this.gMode.rotLeftDown;
            this.crouching = this.control_duckDown && !this.got_air && !this.playing_die_animation;
            this.myCar.hitRectCrouch(this.crouching);
            if(this.crouching)
            {
               this.runSpeed = this.runSpeed_default * 0.1;
            }
            else
            {
               this.runSpeed = this.runSpeed_default;
            }
         }
         else
         {
            this.control_JumpDown = false;
            this.control_duckDown = false;
            this.control_rotRightDown = false;
            this.control_rotLeftDown = false;
            this.control_grenadeDown = false;
            this.control_shoot_down = false;
            this.control_knife_down = false;
            this.crouching = false;
         }
         var _loc1_:Number = Math.atan2(this.myCar.currentX - Camera.mouseTransX,this.myCar.currentY - 10 - Camera.mouseTransY);
         _loc1_ = _loc1_ * (180 / Math.PI * -1);
         if(_loc1_ < 25.71 * -6)
         {
            this.myCar.direction = cBiped.D_DOWNLEFTEXTREME;
         }
         else if(_loc1_ < 25.71 * -5)
         {
            this.myCar.direction = cBiped.D_DOWNLEFT;
         }
         else if(_loc1_ < 25.71 * -4)
         {
            this.myCar.direction = cBiped.D_NEWDOWNLEFT;
         }
         else if(_loc1_ < 25.71 * -3)
         {
            this.myCar.direction = cBiped.D_LEFT;
         }
         else if(_loc1_ < 25.71 * -2)
         {
            this.myCar.direction = cBiped.D_NEWLEFT;
         }
         else if(_loc1_ < 25.71 * -1)
         {
            this.myCar.direction = cBiped.D_UPLEFT;
         }
         else if(_loc1_ < 0)
         {
            this.myCar.direction = cBiped.D_UPLEFTEXTREME;
         }
         else if(_loc1_ > 25.71 * 6)
         {
            this.myCar.direction = cBiped.D_DOWNRIGHTEXTREME;
         }
         else if(_loc1_ > 25.71 * 5)
         {
            this.myCar.direction = cBiped.D_DOWNRIGHT;
         }
         else if(_loc1_ > 25.71 * 4)
         {
            this.myCar.direction = cBiped.D_NEWDOWNRIGHT;
         }
         else if(_loc1_ > 25.71 * 3)
         {
            this.myCar.direction = cBiped.D_RIGHT;
         }
         else if(_loc1_ > 25.71 * 2)
         {
            this.myCar.direction = cBiped.D_NEWRIGHT;
         }
         else if(_loc1_ > 25.71 * 1)
         {
            this.myCar.direction = cBiped.D_UPRIGHT;
         }
         else
         {
            this.myCar.direction = cBiped.D_UPRIGHTEXTREME;
         }
         var _loc3_:* = this.myCar.direction > cBiped.D_PERFECT_DOWN;
         if(this.crouching)
         {
            if(_loc3_)
            {
               this.myCar.direction = cBiped.D_LEFT;
            }
            else
            {
               this.myCar.direction = cBiped.D_RIGHT;
            }
         }
         this.myCar.facingLeft = _loc3_;
         this.myCar.myBodyClip.scaleX = (!!_loc3_?-1:1) * this.myCar.graphicScale;
         if(this.myCar.currentY > 480)
         {
            if(World.currentLevel.myID != Level.LEVEL_7)
            {
               this.myCar.translateTo(this.lastGroundPos.x,this.lastGroundPos.y);
               this.myCar.slug_health = -1;
               this.myCar.takeDamage(this.myCar.slugCast,500);
            }
            else
            {
               GameMode.rPending = this.myCar.slug_lives;
            }
         }
      }
      
      public function shotFired() : void
      {
         this.time_since_fire = 0;
      }
      
      public function sign(param1:Number) : Boolean
      {
         return param1 > 0;
      }
      
      public function ensureConnection() : Boolean
      {
         if(this.myCar == null || this.gMode == null)
         {
            return false;
         }
         return true;
      }
   }
}
