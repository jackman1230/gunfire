package objects
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import nape.constraint.Constraint;
   import nape.constraint.MotorJoint;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import nape.phys.BodyType;
   import nape.shape.Shape;
   
   public class cObject
   {
      
      public static const camera_offset_car_x_default = global.gameWidth / 2 - 40;
      
      public static var camera_offset_car_x:Number = camera_offset_car_x_default;
      
      public static var camera_offset_car_x_targ:Number = camera_offset_car_x_default;
      
      public static const camera_offset_car_y:Number = global.gameHeight / 2 + 5;
      
      public static const object_freeze_distance_default:Number = 70 * 16;
      
      public static var object_freeze_distance:Number = 70 * 16;
       
      
      public var sluggable:Boolean = false;
      
      public var slugCast:slugObject;
      
      public var playerControlled:Boolean = false;
      
      public var world:GameMode;
      
      public var bodyParts:Vector.<Boner>;
      
      public var weightParts:Vector.<Boner>;
      
      public var totalWeightParts:Vector.<Boner>;
      
      public var joints:Vector.<Constraint>;
      
      public var solidBodies:Vector.<Boner>;
      
      public var solidJoints:Vector.<Constraint>;
      
      public var solidTypes:Vector.<Boolean>;
      
      public var objectMass:Number;
      
      public var shapes:Vector.<Shape>;
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var originalX:Number = 0.0;
      
      public var originalY:Number = 0.0;
      
      public var placedX:Number = 0.0;
      
      public var placedY:Number = 0.0;
      
      public var transX:Number = 0.0;
      
      public var transY:Number = 0.0;
      
      public var currentX:Number = 0.0;
      
      public var currentY:Number = 0.0;
      
      public var lastX:Number = 0.0;
      
      public var lastY:Number = 0.0;
      
      public var originalAngle:Number = 0.0;
      
      public var placedAngle:Number = 0.0;
      
      public var currentAngle:Number = 0.0;
      
      public var lastAngle:Number = 0.0;
      
      public var editorRotateable:Boolean = false;
      
      public var aabbWidth:Number = -1;
      
      public var aabbHeight:Number = -1;
      
      public var explodeTimer:int = -1;
      
      public var flaggedTimer:int = -1;
      
      public var editorDraggable:Boolean = true;
      
      public var isDestroyed:Boolean = false;
      
      public var isBreakable:Boolean = false;
      
      public var isBob:Boolean = false;
      
      public var isSmartBoom:Boolean = false;
      
      public var isBombTrigger:Boolean = false;
      
      public var isFraggable:Boolean = false;
      
      public var isProximity:Boolean = false;
      
      public var isBounceTrigger:Boolean = false;
      
      public var isCar:Boolean = false;
      
      public var isUpright:Boolean = false;
      
      public var isAlwaysSensor:Boolean = false;
      
      public var isAlwaysStatic:Boolean = false;
      
      public var isAlwaysFrozen:Boolean = false;
      
      public var isFrozen:Boolean = false;
      
      public var isInfo:Boolean = false;
      
      public var isGround:Boolean = false;
      
      public var isAlwaysEnabled:Boolean = false;
      
      public var sharedJoint:Constraint;
      
      public var myScale:Number = 1;
      
      public var graphicScale:Number = 1;
      
      public var isSentryChild:Boolean = false;
      
      public var typeString:String = null;
      
      public var draggingCount:int = 0;
      
      public var lastPart:Boner;
      
      public var lastJoint:Constraint;
      
      public var numWheels:int = 2;
      
      public var targetID:int = 0;
      
      public var isTarget:Boolean = false;
      
      public var wheelWeight:Number = 1.7;
      
      public var wheelSize:Number = 0.9;
      
      public var motorJoints:Vector.<MotorJoint>;
      
      public var extraSuspensionForce:Number = 14;
      
      public var extraDamping:Number = 300;
      
      public var myMass:Number = 0;
      
      public var totalMass:Number = 0;
      
      public var lockWeight:Boolean = false;
      
      public var suspensions:Vector.<cSuspension>;
      
      public var hasSuspensions:Boolean = false;
      
      public var myHandler:CarHandler;
      
      public var rotationForce:Number = 2;
      
      public var torqueMultiplier:Number = 1;
      
      public var SpeedMultiplier:Number = 1;
      
      public var hubcapMultiplier:Number = 1.1;
      
      public var outOfSight:Boolean = false;
      
      public var lastOutOfSight:Boolean = false;
      
      public var distanceDisabled:Boolean = false;
      
      public var laps:int = 0;
      
      public var totalDistance:int = 0;
      
      public var flagged:Boolean = false;
      
      public var targetToLaunch:cObject;
      
      public var flaggedBodies:Vector.<Boner>;
      
      public var inWarpZone:Boolean = false;
      
      public var myDeformer:Deformer = null;
      
      public var debug_always_visible:Boolean = false;
      
      public var pendingContactFlag:Boolean = false;
      
      public var pendingContactObject:cObject = null;
      
      public var bubbleDest:Vec2;
      
      public var bubbleVelo:Number = 2;
      
      public var totalFrames:int = 0;
      
      public var lastSuspension:cSuspension;
      
      public var gravityTimer:Timer;
      
      public function cObject(param1:Number, param2:Number, param3:GameMode, param4:Number = 0, param5:Boolean = false)
      {
         this.bodyParts = new Vector.<Boner>();
         this.weightParts = new Vector.<Boner>();
         this.totalWeightParts = new Vector.<Boner>();
         this.joints = new Vector.<Constraint>();
         this.solidBodies = new Vector.<Boner>();
         this.solidJoints = new Vector.<Constraint>();
         this.solidTypes = new Vector.<Boolean>();
         this.shapes = new Vector.<Shape>();
         this.motorJoints = new Vector.<MotorJoint>();
         this.suspensions = new Vector.<cSuspension>();
         this.flaggedBodies = new Vector.<Boner>();
         this.bubbleDest = new Vec2(0,0);
         super();
         this.world = GameMode.gameMode;
         if(param5)
         {
            this.x = this.snap(param1);
            this.y = this.snap(param2);
         }
         else
         {
            this.x = param1;
            this.y = param2;
         }
         this.objectMass = 0;
         this.originalX = this.x;
         this.originalY = this.y;
         this.placedX = this.x;
         this.placedY = this.y;
         this.currentX = this.x;
         this.currentY = this.y;
         this.lastX = this.x;
         this.lastY = this.y;
         this.world.lastObject = this;
         this.originalAngle = param4;
         this.placedAngle = param4;
         this.currentAngle = param4;
         this.lastAngle = param4;
         this.editorRotateable = false;
         this.targetID = 0;
         this.isTarget = false;
         this.myHandler = null;
      }
      
      public function toStringE() : String
      {
         return "[cObject sluggable=" + this.sluggable + " slugCast=" + this.slugCast + " playerControlled=" + this.playerControlled + " world=" + this.world + " bodyParts=" + this.bodyParts + " weightParts=" + this.weightParts + " totalWeightParts=" + this.totalWeightParts + " joints=" + this.joints + " solidBodies=" + this.solidBodies + " solidJoints=" + this.solidJoints + " solidTypes=" + this.solidTypes + " objectMass=" + this.objectMass + " shapes=" + this.shapes + " x=" + this.x + " y=" + this.y + " originalX=" + this.originalX + " originalY=" + this.originalY + " placedX=" + this.placedX + " placedY=" + this.placedY + " transX=" + this.transX + " transY=" + this.transY + " currentX=" + this.currentX + " currentY=" + this.currentY + " lastX=" + this.lastX + " lastY=" + this.lastY + " originalAngle=" + this.originalAngle + " placedAngle=" + this.placedAngle + " currentAngle=" + this.currentAngle + " lastAngle=" + this.lastAngle + " editorRotateable=" + this.editorRotateable + " aabbWidth=" + this.aabbWidth + " aabbHeight=" + this.aabbHeight + " explodeTimer=" + this.explodeTimer + " flaggedTimer=" + this.flaggedTimer + " editorDraggable=" + this.editorDraggable + " isDestroyed=" + this.isDestroyed + " isBreakable=" + this.isBreakable + " isBob=" + this.isBob + " isSmartBoom=" + this.isSmartBoom + " isBombTrigger=" + this.isBombTrigger + " isFraggable=" + this.isFraggable + " isProximity=" + this.isProximity + " isBounceTrigger=" + this.isBounceTrigger + " isCar=" + this.isCar + " isUpright=" + this.isUpright + " isAlwaysSensor=" + this.isAlwaysSensor + " isAlwaysStatic=" + this.isAlwaysStatic + " isAlwaysFrozen=" + this.isAlwaysFrozen + " isFrozen=" + this.isFrozen + " isInfo=" + this.isInfo + " isGround=" + this.isGround + " isAlwaysEnabled=" + this.isAlwaysEnabled + " sharedJoint=" + this.sharedJoint + " myScale=" + this.myScale + " graphicScale=" + this.graphicScale + " isSentryChild=" + this.isSentryChild + " typeString=" + this.typeString + " draggingCount=" + this.draggingCount + " lastPart=" + this.lastPart + " lastJoint=" + this.lastJoint + " numWheels=" + this.numWheels + " targetID=" + this.targetID + " isTarget=" + this.isTarget + " wheelWeight=" + this.wheelWeight + " wheelSize=" + this.wheelSize + " motorJoints=" + this.motorJoints + " extraSuspensionForce=" + this.extraSuspensionForce + " extraDamping=" + this.extraDamping + " myMass=" + this.myMass + " totalMass=" + this.totalMass + " lockWeight=" + this.lockWeight + " suspensions=" + this.suspensions + " hasSuspensions=" + this.hasSuspensions + " myHandler=" + this.myHandler + " rotationForce=" + this.rotationForce + " torqueMultiplier=" + this.torqueMultiplier + " SpeedMultiplier=" + this.SpeedMultiplier + " hubcapMultiplier=" + this.hubcapMultiplier + " outOfSight=" + this.outOfSight + " lastOutOfSight=" + this.lastOutOfSight + " distanceDisabled=" + this.distanceDisabled + " laps=" + this.laps + " totalDistance=" + this.totalDistance + " flagged=" + this.flagged + " targetToLaunch=" + this.targetToLaunch + " flaggedBodies=" + this.flaggedBodies + " inWarpZone=" + this.inWarpZone + " myDeformer=" + this.myDeformer + " camera_offset_car_x=" + camera_offset_car_x + " camera_offset_car_x_targ=" + camera_offset_car_x_targ + " object_freeze_distance=" + object_freeze_distance + " debug_always_visible=" + this.debug_always_visible + " pendingContactFlag=" + this.pendingContactFlag + " pendingContactObject=" + this.pendingContactObject + " bubbleDest=" + this.bubbleDest + " bubbleVelo=" + this.bubbleVelo + " totalFrames=" + this.totalFrames + " lastSuspension=" + this.lastSuspension + " gravityTimer=" + this.gravityTimer + "]";
      }
      
      public function setBubbleDest(param1:Number, param2:Number) : *
      {
         this.bubbleDest = new Vec2(param1,param2);
         this.bubbleVelo = this.bubbleVelo + Math.random();
      }
      
      public function snap(param1:Number) : Number
      {
         return Math.round(param1);
      }
      
      public function postCreate() : *
      {
         this.calculateMass();
         if(this.isCar && !World.currentLevel.inEditor)
         {
            if(this is cHitler)
            {
               this.myHandler = new HitlerHandler(this.world,this);
            }
            else if(this is cTank)
            {
               this.myHandler = new AITankHandler(this.world,this);
            }
            else if(this is cSwordsMan)
            {
               this.myHandler = new AISwordHandler(this.world,this);
            }
            else if(this is cSoldier)
            {
               this.myHandler = new AICarHandler(this.world,this);
            }
            else
            {
               this.myHandler = new CarHandler(this.world,this);
            }
         }
         if(World.currentLevel.inEditor)
         {
            this.freeze();
         }
         else if(!this.isCar)
         {
            this.disable(true);
         }
         BoxUtils.lastShape = null;
      }
      
      public function destroy() : void
      {
         var _loc2_:int = 0;
         if(!World.stepLock)
         {
            if(this.bodyParts.length > 0 && this.bodyParts[0] != null && this.bodyParts[0].userData.sprite != null)
            {
               this.bodyParts[0].userData.sprite.addChild(new customFont(20,"FOOOO",false));
            }
            while(this.suspensions.length > 0)
            {
               if(this.suspensions[0] != null)
               {
                  this.suspensions[_loc2_].removeMe();
               }
               this.suspensions.splice(0,1);
            }
            _loc2_ = 0;
            while(_loc2_ < this.joints.length)
            {
               if(this.joints[0] != null)
               {
                  (this.joints[0] as Constraint).userData.skipDrawing = false;
                  EntUtils.destroyJoint(this.joints[0]);
                  this.joints.splice(0,1);
               }
               _loc2_++;
            }
            this.solidBodies = null;
            this.solidJoints = null;
            this.solidTypes = null;
            while(this.bodyParts.length > 0)
            {
               if(this.bodyParts[0] != null)
               {
                  this.removePart(this.bodyParts[0]);
               }
            }
            this.clearHandler();
            this.killSharedJoint();
            this.isDestroyed = true;
         }
      }
      
      public function clearHandler() : *
      {
         if(this.myHandler != null)
         {
            if(this.myHandler.myCar != null)
            {
               this.myHandler.myCar = null;
            }
            this.myHandler.gMode = null;
            this.myHandler = null;
         }
      }
      
      public function updatePos() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:Number = NaN;
         if(this.bodyParts.length > 0)
         {
            this.currentX = this.bodyParts[0].position.x - this.transX;
            this.currentY = this.bodyParts[0].position.y - this.transY;
            this.currentAngle = (this.bodyParts[0] as Body).rotation;
         }
         if(World.currentLevel.allowWrapping)
         {
            this.totalDistance = this.currentX - GroundUtils.sectionWidth / World.gameScale + GroundUtils.sectionWidth * 5 * this.laps / World.gameScale;
         }
         else
         {
            this.totalDistance = this.currentX;
         }
         if(World.currentLevel.allowWrapping)
         {
            _loc1_ = GroundUtils.sectionWidth * 5 / World.gameScale;
            _loc2_ = GroundUtils.sectionWidth * 6 / World.gameScale;
            if(this.currentX > _loc2_)
            {
               _loc3_ = 0;
               this.translateMe(-_loc1_,-_loc3_ / World.gameScale);
               if(this == World.followObj)
               {
                  Camera.followX = Camera.followX - _loc1_ * World.gameScale;
                  Camera.targX = Camera.targX - _loc1_ * World.gameScale;
                  Camera.followY = Camera.followY - _loc3_;
                  Camera.targY = Camera.targY - _loc3_;
               }
               this.laps++;
               if(this == World.followObj)
               {
                  this.world.collection2("Distance bonus! x" + this.laps.toString(),this.laps * 1000);
                  ScoreHandler.addStunt(this.laps * 1000,"Distance bonus! x" + this.laps.toString());
               }
               this.updatePos();
            }
            if(this.currentX < GroundUtils.sectionWidth / World.gameScale)
            {
               this.boostSpeed(1.1,1,true,false,false,false);
            }
         }
         else if(this.currentY < -200)
         {
            this.translateMe(0,10);
            if(this.world.frameCount % 10 == 0)
            {
               this.world.collection2("Soaring too high",666);
            }
         }
      }
      
      public function showParts(param1:Boolean) : *
      {
         var _loc3_:Sprite = null;
         if(this is cCoin)
         {
         }
         if(this.myDeformer != null)
         {
            if(!param1)
            {
            }
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.bodyParts.length)
         {
            _loc3_ = this.bodyParts[_loc2_].userData.sprite;
            if(_loc3_)
            {
               _loc3_.visible = param1;
            }
            _loc2_++;
         }
      }
      
      public function translateToBody(param1:Boner) : void
      {
         if(param1 != null)
         {
            this.translateTo(param1.position.x,param1.position.y);
         }
      }
      
      public function translateTo(param1:Number, param2:Number) : *
      {
         this.translateMe(-this.currentX + param1,-this.currentY + param2);
      }
      
      public function translateMe(param1:Number, param2:Number) : *
      {
         var _loc3_:Vec2 = null;
         var _loc5_:Boner = null;
         var _loc4_:int = 0;
         while(_loc4_ < this.bodyParts.length)
         {
            _loc3_ = new Vec2(0,0);
            _loc5_ = this.bodyParts[_loc4_];
            if(_loc5_ != null)
            {
               _loc3_ = _loc5_.position.copy();
               _loc3_.addeq(new Vec2(param1,param2));
               _loc5_.position = _loc3_;
            }
            _loc4_++;
         }
      }
      
      public function checkWarpZone() : void
      {
         this.inWarpZone = false;
         var _loc1_:Number = this.currentX * World.gameScale;
         if(_loc1_ < GroundUtils.sectionWidth + 640 && GroundUtils.carSection == 5)
         {
            this.inWarpZone = true;
         }
         if(_loc1_ > GroundUtils.sectionWidth * 6 - 640 && GroundUtils.carSection == 1)
         {
            this.inWarpZone = true;
         }
      }
      
      public function calculateVisibility(param1:cObject) : void
      {
         this.checkWarpZone();
         if(this is cCarryable && !this.distanceDisabled)
         {
         }
         if(param1 && param1 != this && !this.debug_always_visible)
         {
            if(!World.currentLevel.inEditor)
            {
               if(Math.abs(param1.currentX - this.currentX) <= object_freeze_distance)
               {
                  this.outOfSight = false;
               }
               if(this.lastOutOfSight != this.outOfSight)
               {
                  if(this.outOfSight && !GameMode.goal)
                  {
                     if(!this.isAlwaysEnabled)
                     {
                        this.disable();
                     }
                  }
                  else
                  {
                     this.enable();
                  }
               }
            }
         }
         else
         {
            this.outOfSight = false;
            this.showParts(true);
         }
         this.lastOutOfSight = this.outOfSight;
      }
      
      public function disable(param1:Boolean = false) : void
      {
         if(!this.isAlwaysEnabled || param1)
         {
            this.distanceDisabled = true;
            this.freeze();
            this.setSensor();
            this.removeContactListeners();
         }
         this.checkWarpZone();
         if(!this.inWarpZone)
         {
            this.showParts(false);
         }
         if(param1)
         {
            this.lastOutOfSight = true;
         }
      }
      
      public function enable() : void
      {
         this.distanceDisabled = false;
         this.unfreeze();
         this.removeSensor();
         this.newContactListeners();
         this.showParts(true);
      }
      
      public function carContact(param1:cObject) : void
      {
      }
      
      public function contact(param1:Vec2, param2:Vec2, param3:Boner, param4:Boner) : void
      {
         if(this.carContactCheck(param3))
         {
            this.pendingContactObject = param3.userData.owner;
            this.pendingContactFlag = true;
         }
         param4.userData.beenTouched = true;
      }
      
      public function carContactCheck(param1:Boner) : Boolean
      {
         if(!this.pendingContactFlag && param1 != null && param1.userData.owner != null && param1.userData.owner is cCar && !this.flagged && !this.isDestroyed)
         {
            this.pendingContactFlag = true;
            return true;
         }
         return false;
      }
      
      public function solidify(param1:Boner) : void
      {
         if(World.currentLevel.inEditor)
         {
            this.makeWorldJoint(param1,true);
         }
         else
         {
            param1.userData.alwaysStatic = true;
            param1.type = BodyType.STATIC;
         }
      }
      
      public function slideBox(param1:Number, param2:Number) : void
      {
         this.addPart(BoxUtils.NewBox(this.x + param1 / World.gameScale,this.y + param2 / World.gameScale,1,0.5,1,true,Filters.car,Filters.carMask,0));
         this.lastPart.userData.isRail = true;
      }
      
      public function slideBoxE(param1:Number, param2:Number) : void
      {
         this.addPart(BoxUtils.NewOBox(this.x + param1 / World.gameScale,this.y + param2 / World.gameScale,1,0.5,0,true,Math.atan2(80,140),Filters.car,Filters.carMask,0));
         this.lastPart.userData.isRail = true;
      }
      
      public function setGravityFactor(param1:Number) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.bodyParts.length)
         {
            if(this.bodyParts[_loc2_] != null)
            {
               this.bodyParts[_loc2_].userData.gravityMultiplier = param1;
            }
            _loc2_++;
         }
      }
      
      public function rotateAboutPoint(param1:Number = 1) : void
      {
         var _loc4_:Boner = null;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc2_:Number = param1 * -1;
         var _loc3_:int = 0;
         while(_loc3_ < this.bodyParts.length)
         {
            if(this.bodyParts[_loc3_] != null)
            {
               _loc4_ = this.bodyParts[_loc3_];
               _loc5_ = Math.sin(_loc2_);
               _loc6_ = Math.cos(_loc2_);
               _loc7_ = this.currentY;
               _loc8_ = this.currentX;
               _loc9_ = _loc4_.position.x - _loc8_;
               _loc10_ = _loc4_.position.y - _loc7_;
               _loc11_ = _loc8_ + (_loc9_ * _loc6_ + _loc10_ * _loc5_);
               _loc12_ = _loc7_ + (_loc10_ * _loc6_ - _loc9_ * _loc5_);
               _loc4_.position = new Vec2(_loc11_,_loc12_);
               _loc4_.rotation = param1;
            }
            _loc3_++;
         }
      }
      
      public function checkDespawn() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(World.currentLevel.allowWrapping && !this.debug_always_visible)
         {
            if(!this.isDestroyed && !this.flagged)
            {
               _loc1_ = Math.floor(this.bodyParts[0].position.x * World.gameScale / GroundUtils.sectionWidth);
               if(World.followObj != null && this != World.followObj)
               {
                  _loc2_ = GroundUtils.carSection;
                  if(_loc1_ == 1 && (_loc2_ == 3 || _loc2_ == 4))
                  {
                     this.flagged = true;
                  }
                  if(_loc1_ == 2 && (_loc2_ == 4 || _loc2_ == 5))
                  {
                     this.flagged = true;
                  }
                  if(_loc1_ == 3 && (_loc2_ == 5 || _loc2_ == 1))
                  {
                     this.flagged = true;
                  }
                  if(_loc1_ == 4 && (_loc2_ == 1 || _loc2_ == 2))
                  {
                     this.flagged = true;
                  }
                  if(_loc1_ == 5 && (_loc2_ == 2 || _loc2_ == 3))
                  {
                     this.flagged = true;
                  }
                  if(_loc1_ < 1 || _loc1_ > 5)
                  {
                     this.flagged = true;
                  }
               }
            }
         }
      }
      
      public function tick(param1:cObject = null) : void
      {
         this.checkDespawn();
         if(!this.isDestroyed)
         {
            this.updatePos();
            this.calculateVisibility(param1);
            if(this.flaggedTimer > -1)
            {
               this.flaggedTimer--;
               if(this.flaggedTimer == -1)
               {
                  this.flagged = true;
               }
            }
            if(!this.distanceDisabled && !World.currentLevel.inEditor)
            {
               if(this.explodeTimer > -1)
               {
                  this.explodeTimer--;
                  if(this.explodeTimer == -1)
                  {
                     if(this.isBreakable)
                     {
                        this.isBreakable = false;
                        this.blowUp(this.currentX,this.currentY);
                     }
                     else
                     {
                        this.flagged = true;
                     }
                  }
               }
               if(this.isProximity)
               {
                  this.processNeighbours();
               }
               if(this.isAlwaysFrozen && !this.isFrozen)
               {
                  this.freeze();
               }
               if(this.isUpright)
               {
                  if(GameMode.playing && this.bodyParts.length > 0)
                  {
                     (this.bodyParts[0] as Body).position = new Vec2(this.bodyParts[0].userData.placedX,this.bodyParts[0].userData.placedY);
                     this.bodyParts[0].rotation = this.placedAngle;
                  }
               }
               if(GameMode.playing && this.hasSuspensions && !World.currentLevel.inEditor)
               {
                  this.updateSuspension();
               }
               if(this.pendingContactObject != null)
               {
                  if(this.sharedJoint != null)
                  {
                     this.killSharedJoint();
                  }
                  this.carContact(this.pendingContactObject);
                  this.pendingContactObject = null;
               }
               this.totalFrames++;
               this.subTick();
               if(this.myDeformer != null && this.myDeformer.listenersEnabled)
               {
                  this.myDeformer.onFrame(null);
               }
               this.removeFlaggedBodies();
               if(!this.playerControlled && this.isCar && this.myHandler)
               {
                  this.myHandler.tick();
               }
            }
            if(this.playerControlled && this.isCar && this.myHandler)
            {
               this.myHandler.tick();
            }
         }
      }
      
      public function subTick() : void
      {
      }
      
      public function updateSuspension() : *
      {
         var _loc3_:cSuspension = null;
         for each(_loc3_ in this.suspensions)
         {
            _loc3_.update();
         }
      }
      
      public function processNeighbours() : void
      {
      }
      
      public function blowUp(param1:Number, param2:Number) : *
      {
         var _loc4_:int = 0;
         if(!this.isDestroyed)
         {
            this.unfreeze();
            while(this.joints.length > 0)
            {
               EntUtils.destroyJoint(this.joints[0]);
               this.joints.splice(0,1);
            }
            this.solidJoints = null;
            this.solidTypes = null;
            this.solidBodies = null;
            _loc4_ = 0;
            while(_loc4_ < this.bodyParts.length)
            {
               this.asplodePart(this.bodyParts[_loc4_],param1,param2,false);
               _loc4_++;
            }
            if(this.isFraggable)
            {
               this.createFrag();
            }
            this.postExplode();
            _loc4_ = 0;
            while(_loc4_ < this.shapes.length)
            {
               this.shapes[_loc4_].body.type = BodyType.KINEMATIC;
               _loc4_++;
            }
            this.killSharedJoint();
            this.flaggedTimer = 50;
         }
      }
      
      public function killSharedJoint() : void
      {
         if(this.sharedJoint != null)
         {
            EntUtils.destroyJoint(this.sharedJoint);
         }
         this.sharedJoint = null;
      }
      
      public function postExplode() : void
      {
      }
      
      public function createFrag() : *
      {
         var _loc1_:cObject = null;
         _loc1_ = new cFrag(this.currentX,this.currentY,this.world);
         LevelUtils.levelOb(_loc1_);
      }
      
      public function boostSpeed(param1:Number = 1.5, param2:Number = 1.5, param3:Boolean = true, param4:* = false, param5:Boolean = false, param6:Boolean = false) : *
      {
         var _loc8_:Vec2 = null;
         var _loc7_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < this.bodyParts.length)
         {
            _loc8_ = this.bodyParts[_loc7_].velocity;
            _loc8_.x = _loc8_.x * param1;
            _loc8_.y = _loc8_.y * param2;
            if(param3)
            {
               _loc8_.x = Math.abs(_loc8_.x);
            }
            if(param5)
            {
               _loc8_.y = Math.abs(_loc8_.y);
            }
            if(param6)
            {
               _loc8_.y = _loc8_.y * -1;
            }
            if(param4)
            {
               _loc8_.x = _loc8_.x * -1;
            }
            this.bodyParts[_loc7_].velocity = _loc8_;
            _loc7_++;
         }
      }
      
      public function setContactTrigger(param1:Boner) : *
      {
         param1.userData.contactTrigger = true;
      }
      
      public function removeFlaggedBodies() : void
      {
         if(this.flaggedBodies.length > 0 && !World.stepLock)
         {
            while(this.flaggedBodies.length > 0)
            {
               this.removePart(this.flaggedBodies[0]);
            }
         }
      }
      
      public function removePart(param1:Boner) : *
      {
         if(World.stepLock)
         {
            if(this.flaggedBodies.indexOf(param1) == -1)
            {
               this.flaggedBodies.push(param1);
            }
         }
         else if(param1 != null)
         {
            SpriteUtils.killData(param1);
            if(this.flaggedBodies.indexOf(param1) > -1)
            {
               this.flaggedBodies.splice(this.flaggedBodies.indexOf(param1),1);
            }
            this.bodyParts.splice(this.bodyParts.indexOf(param1),1);
            EntUtils.destroyBody(param1);
         }
      }
      
      public function asplodePart(param1:Boner, param2:Number, param3:Number, param4:Boolean) : *
      {
         var _loc6_:Vec2 = new Vec2(param1.position.x - param2,param1.position.y - param3);
         var _loc7_:int = Math.sqrt(_loc6_.lsq());
         if(_loc7_ != 0)
         {
            _loc6_.muleq(1 / _loc7_);
         }
         _loc6_.muleq(10);
         _loc6_.addeq(param1.velocity);
         param1.velocity = _loc6_;
      }
      
      public function returnPart(param1:Boner, param2:Number, param3:Number, param4:Boolean) : *
      {
         if(!param4)
         {
            param1.applyLocalForce(new Vec2((param1.position.x - param2) * -6,(param1.position.y - param3) * -6),param1.position);
         }
         else
         {
            param1.applyLocalForce(new Vec2(0,(param1.position.y - param3) * -6),param1.position);
         }
      }
      
      public function grinding() : void
      {
      }
      
      public function setUpright(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         if(this != World.followObj && !this.isCar)
         {
            _loc2_ = 0;
            while(_loc2_ < this.bodyParts.length)
            {
               if(this.bodyParts[_loc2_] != null)
               {
                  this.bodyParts[0].rotation = 0;
               }
               _loc2_++;
            }
         }
      }
      
      public function dragging() : void
      {
         this.updatePos();
         this.placedX = this.currentX;
         this.placedY = this.currentY;
         this.placedAngle = this.currentAngle;
      }
      
      public function setLastPos() : *
      {
         this.lastX = this.currentX;
         this.lastY = this.currentY;
         this.lastAngle = this.currentAngle;
      }
      
      public function overWritePos() : *
      {
         this.currentY = this.lastY;
         this.currentX = this.lastX;
         this.placedX = this.lastX;
         this.placedY = this.lastY;
         this.originalX = this.lastX;
         this.originalY = this.lastY;
         this.currentAngle = this.lastAngle;
         this.placedAngle = this.lastAngle;
         this.currentAngle = this.lastAngle;
      }
      
      public function refilter() : void
      {
      }
      
      public function setSensor() : Boolean
      {
         var _loc3_:Boner = null;
         for each(_loc3_ in this.bodyParts)
         {
            _loc3_.type = BodyType.KINEMATIC;
         }
         this.refilter();
         return false;
      }
      
      public function calculateMass() : *
      {
         var _loc1_:int = 0;
         this.myMass = 0;
         this.totalMass = 0;
         _loc1_ = 0;
         while(_loc1_ < this.weightParts.length)
         {
            this.myMass = this.myMass + this.weightParts[_loc1_].mass;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.totalWeightParts.length)
         {
            this.totalMass = this.totalMass + this.totalWeightParts[_loc1_].mass;
            _loc1_++;
         }
      }
      
      public function freeze() : *
      {
         var _loc1_:Boner = null;
         for each(_loc1_ in this.bodyParts)
         {
            _loc1_.allowMovement = false;
            _loc1_.allowRotation = false;
         }
      }
      
      public function unfreeze() : Boolean
      {
         var _loc1_:Boner = null;
         for each(_loc1_ in this.bodyParts)
         {
            _loc1_.allowMovement = true;
            _loc1_.allowRotation = true;
         }
         return false;
      }
      
      public function removeSensor() : Boolean
      {
         var _loc3_:Boner = null;
         if(!this.isAlwaysSensor)
         {
            if(this.isAlwaysStatic)
            {
               for each(_loc3_ in this.bodyParts)
               {
                  _loc3_.type = BodyType.STATIC;
               }
            }
            else
            {
               for each(_loc3_ in this.bodyParts)
               {
                  if(!_loc3_.userData.isAlwaysSensor)
                  {
                     _loc3_.type = BodyType.DYNAMIC;
                  }
               }
            }
         }
         this.refilter();
         return false;
      }
      
      public function addPoly(param1:Number, param2:Boolean, param3:Array, param4:int = 0, param5:int = -1, param6:Boolean = false, param7:Number = 1, param8:Number = 1) : *
      {
         BoxUtils.lastShape = BoxUtils.defineShape(param1,param2,param3,param4,param5,param8,param6,param7);
         BoxUtils.lastShape.body = this.lastPart;
         this.addShape(!param2);
      }
      
      public function removeContactListeners() : *
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.bodyParts.length)
         {
            if(this.bodyParts[_loc1_].userData.contactList)
            {
               this.bodyParts[_loc1_].userData.contactList.clear();
               this.bodyParts[_loc1_].userData.contactList = null;
            }
            _loc1_++;
         }
      }
      
      public function newContactListeners() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.bodyParts.length)
         {
            this.addContactListener(this.bodyParts[_loc1_]);
            _loc1_++;
         }
      }
      
      public function addContactListener(param1:Boner) : *
      {
         param1.userData.contactList = new EContactList();
      }
      
      public function makeStatic() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.bodyParts.length)
         {
            this.bodyParts[_loc1_].type = BodyType.STATIC;
            _loc1_++;
         }
      }
      
      public function makeDynamic() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.bodyParts.length)
         {
            if(!this.bodyParts[_loc1_].userData.alwaysStatic || World.currentLevel.inEditor)
            {
               this.bodyParts[_loc1_].type = BodyType.DYNAMIC;
            }
            _loc1_++;
         }
      }
      
      public function addPart(param1:Boner, param2:Sprite = null, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false) : *
      {
         if(param1 != null)
         {
            if(!param5)
            {
            }
            if(param1.type == BodyType.STATIC)
            {
            }
            if(param4)
            {
               this.setContactTrigger(param1);
            }
            if(param1.userData.contactTrigger)
            {
               this.addContactListener(param1);
            }
            if(this.bodyParts.length == 0)
            {
               this.transX = param1.position.x - this.originalX;
               this.transY = param1.position.y - this.originalY;
            }
            if(param5 || this.isAlwaysStatic)
            {
               param1.userData.alwaysStatic = true;
               param1.type = BodyType.STATIC;
            }
            this.bodyParts.push(param1);
            if(!this.lockWeight)
            {
               this.weightParts.push(param1);
            }
            this.totalWeightParts.push(param1);
            param1.userData.owner = this;
            this.objectMass = this.objectMass + param1.mass;
            param1.userData.placedX = param1.position.x;
            param1.userData.placedY = param1.position.y;
            this.addShape(param3);
            this.lastPart = param1;
            if(param2 != null)
            {
               this.setData(param1,param2);
            }
         }
      }
      
      public function addShape(param1:Boolean = false) : *
      {
         BoxUtils.lastShape.userData.isAlwaysSensor = param1;
         if(BoxUtils.lastShape != null)
         {
            this.shapes.push(BoxUtils.lastShape);
         }
      }
      
      public function addJoint(param1:Constraint) : *
      {
         this.joints.push(param1);
         this.lastJoint = param1;
      }
      
      public function addSuspension(param1:cObject, param2:Boner, param3:Boner, param4:Boner, param5:Number = -1, param6:Number = 0) : cSuspension
      {
         var _loc7_:cSuspension = new cSuspension(param1,param2,param3,param4,param5,param6);
         this.suspensions.push(_loc7_);
         this.hasSuspensions = true;
         this.lastSuspension = _loc7_;
         return _loc7_;
      }
      
      public function makeMotor() : *
      {
         if(this.lastJoint)
         {
            this.motorJoints.push(this.lastJoint);
         }
      }
      
      public function removeJoint(param1:Constraint) : *
      {
         if(param1 && this.joints.lastIndexOf(param1) > -1)
         {
            this.joints.splice(this.joints.indexOf(param1),1);
            EntUtils.destroyJoint(param1);
         }
      }
      
      public function gravityMultiplier(param1:Number = 1, param2:int = 0) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < this.bodyParts.length)
         {
            this.bodyParts[_loc3_].gravMassScale = param1;
            _loc3_++;
         }
         if(param2 > 0)
         {
            this.gravityTimer = new Timer(param2,1);
            this.gravityTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.resetGravity);
            this.gravityTimer.start();
         }
      }
      
      public function resetGravity(param1:Event = null) : void
      {
         this.gravityTimer.stop();
         this.gravityMultiplier(1);
      }
      
      public function bringAllToFront() : void
      {
         if(this.isCar && this is cCar)
         {
            (this as cCar).createGraphics();
         }
      }
      
      public function sendToBack(param1:Boner) : void
      {
         var _loc2_:Sprite = null;
         if(param1.userData.sprite != null)
         {
            _loc2_ = param1.userData.sprite;
            _loc2_.parent.setChildIndex(_loc2_,0);
         }
      }
      
      public function bringToFront(param1:Boner) : void
      {
         var _loc2_:Sprite = null;
         if(param1.userData.sprite != null)
         {
            _loc2_ = param1.userData.sprite;
            _loc2_.parent.setChildIndex(_loc2_,_loc2_.parent.numChildren - 1);
         }
      }
      
      public function setData(param1:Boner, param2:Sprite, param3:Number = 0) : Sprite
      {
         SpriteUtils.killData(param1);
         if(param2 != null && param2 is Sprite && param1 != null)
         {
            SpriteUtils.setData(param1,param2);
            param1.userData.sprite = param2;
            if(param3 > 0)
            {
               param2.width = param3 * World.gameScale * 2 * 1.3;
               param2.height = param3 * World.gameScale * 2 * 1.3;
            }
            else
            {
               param2.scaleX = param2.scaleX * (this.myScale * this.graphicScale);
               param2.scaleY = param2.scaleY * (this.myScale * this.graphicScale);
            }
         }
         return param2;
      }
      
      public function Update() : *
      {
      }
      
      public function performFunction(param1:int) : *
      {
      }
      
      public function unhookSolid() : *
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.solidBodies.length)
         {
            if(this.solidJoints[_loc1_] != null)
            {
               EntUtils.destroyJoint(this.solidJoints[_loc1_]);
            }
            _loc1_++;
         }
      }
      
      public function rehookSolid() : *
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.solidBodies.length)
         {
            this.makeWorldJoint(this.solidBodies[_loc1_],this.solidTypes[_loc1_]);
            _loc1_++;
         }
      }
      
      public function makeWorldJoint(param1:Boner, param2:Boolean) : void
      {
         if(param1 != null)
         {
            if(this.solidBodies.indexOf(param1) < 0)
            {
               if(this.solidBodies.indexOf(param1) < 0)
               {
                  this.solidBodies.push(param1);
                  this.solidTypes.push(param2);
               }
               if(param2)
               {
                  this.solidJoints.push(BoxUtils.NewRevJoint(World.m_world.world,param1,-360,360,false,false));
               }
               else
               {
                  this.solidJoints.push(BoxUtils.NewRevJoint(World.m_world.world,param1,0,0,true,false));
               }
            }
         }
      }
      
      public function launchTarget() : *
      {
         var _loc1_:int = 0;
         var _loc2_:Boner = null;
         var _loc5_:cObject = null;
         _loc1_ = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         if(this.targetToLaunch != null)
         {
            _loc5_ = this.targetToLaunch;
            _loc3_ = _loc5_.totalMass / _loc5_.bodyParts.length * 0.5;
            if(World.invulnerabilityCounter > -1)
            {
               _loc4_ = 0;
            }
            else
            {
               _loc4_ = -_loc3_;
               _loc1_ = 0;
               while(_loc1_ < _loc5_.bodyParts.length)
               {
                  _loc2_ = _loc5_.bodyParts[_loc1_];
                  _loc2_.velocity = new Vec2(_loc2_.velocity.x + 0.2,-10);
                  _loc2_.applyLocalForce(new Vec2(_loc3_,_loc4_));
                  _loc2_.angularVel = 0;
                  _loc1_++;
               }
            }
         }
      }
   }
}
