package
{
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import objects.cCar;
   import objects.cObject;
   
   public class Camera
   {
      
      public static var self:Camera;
      
      public static var followX:Number = 0;
      
      public static var followY:Number = 0;
      
      public static var targX:Number = 0;
      
      public static var targY:Number = 0;
      
      public static var followOffsetX:Number = 0;
      
      public static var followOffsetY:Number = 0;
      
      public static var backgroundX:Number = 0;
      
      public static var backgroundY:Number = 0;
      
      public static var backgroundX2:Number = 0;
      
      public static var backgroundY2:Number = 0;
      
      public static var backgroundX3:Number = 0;
      
      public static var backgroundY3:Number = 0;
      
      public static var backgroundX4:Number = 0;
      
      public static var backgroundY4:Number = 0;
      
      public static var mouseTransX:Number = 0;
      
      public static var mouseTransY:Number = 0;
      
      private static var following:Boolean = true;
      
      public static var camScale:Number = 1;
      
      public static var targScale:Number = 1;
      
      public static var scaledWidth:Number = global.gameWidth;
      
      public static var scaledHeight:Number = global.gameHeight;
      
      public static var bossLocked:Boolean = false;
       
      
      public function Camera()
      {
         super();
         self = this;
      }
      
      public static function update() : void
      {
         applyScales();
         targToFollow();
         updateFollowCam();
         applyRectlimits();
         applyCamPos();
         updateMouseTranslation();
      }
      
      public static function applyScales() : void
      {
         var _loc1_:cCar = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(World.currentLevel.autoScaling && World.following && GameMode.control && World.currentLevel.controlable)
         {
            _loc1_ = World.followObj as cCar;
            _loc2_ = Math.abs(_loc1_.bodyParts[0].velocity.x);
            _loc3_ = _loc2_ / 80;
            if(_loc3_ > 0.3)
            {
               _loc3_ = 0.3;
            }
            targScale = 1 - _loc3_;
            targScale = 1;
         }
         camScale = camScale + (targScale - camScale) / 28;
         if(SpriteUtils.gameClip.scaleX != camScale)
         {
            SpriteUtils.gameClip.scaleX = camScale;
            SpriteUtils.gameClip.scaleY = camScale;
            if(SpriteUtils.transferClip != null)
            {
               SpriteUtils.transferClip.scaleX = camScale;
               SpriteUtils.transferClip.scaleY = camScale;
            }
         }
         scaledWidth = global.gameWidth / camScale;
         scaledHeight = global.gameHeight / camScale;
         cObject.object_freeze_distance = cObject.object_freeze_distance_default / camScale;
      }
      
      public static function applyCamPos() : void
      {
         var _loc1_:Sprite = SpriteUtils.gameClip;
         var _loc2_:Sprite = SpriteUtils.bgClip;
         var _loc3_:Sprite = SpriteUtils.bg2Clip;
         var _loc4_:Sprite = SpriteUtils.bg3Clip;
         var _loc5_:Sprite = SpriteUtils.bg4Clip;
         var _loc6_:int = scaledWidth;
         var _loc7_:int = scaledHeight;
         if(World.followObj != null && World.following || World.currentLevel.inEditor)
         {
            _loc1_.scrollRect = new Rectangle(Camera.followX,Camera.followY,_loc6_,_loc7_);
            if((World.currentLevel.allowWrapping || World.currentLevel.transferClip) && SpriteUtils.transferClip != null)
            {
               SpriteUtils.transferClip.scrollRect = new Rectangle(Camera.followX,Camera.followY,_loc6_,_loc7_);
            }
         }
         else
         {
            _loc1_.scrollRect = new Rectangle(Camera.followX,0,_loc6_,_loc7_);
         }
         if(!World.currentLevel.inEditor)
         {
            if(World.currentLevel.goingLeft)
            {
               if(followX < LevelUtils.highestX)
               {
                  LevelUtils.highestX = Camera.followX;
               }
            }
            else if(followX > LevelUtils.highestX)
            {
               LevelUtils.highestX = Camera.followX;
            }
         }
         _loc2_.scrollRect = new Rectangle(backgroundX,backgroundY,global.gameWidth,global.gameHeight);
         _loc3_.scrollRect = new Rectangle(backgroundX2,backgroundY2,global.gameWidth,global.gameHeight);
         _loc4_.scrollRect = new Rectangle(backgroundX3,backgroundY3,global.gameWidth,global.gameHeight);
         _loc5_.scrollRect = new Rectangle(backgroundX4,backgroundY4,global.gameWidth,global.gameHeight);
         _loc4_.visible = false;
         _loc5_.visible = false;
      }
      
      public static function setCamPos(param1:Number, param2:Number, param3:Boolean = false) : void
      {
         setFollowing(param3);
         targX = param1;
         targY = param2;
      }
      
      public static function setFollowing(param1:Boolean = true) : void
      {
         following = param1;
         if(param1)
         {
            targToFollow();
         }
      }
      
      public static function updateFollowCam() : void
      {
         if(following)
         {
            followX = followX + (targX - followX) / 3;
            followY = followY + (targY - followY) / 3;
         }
         else
         {
            followX = targX;
            followY = targY;
         }
      }
      
      public static function setScale(param1:Number = 1, param2:Boolean = false) : *
      {
         targScale = param1;
         if(param2)
         {
            camScale = targScale;
         }
      }
      
      public static function addScale(param1:Number = 1, param2:Boolean = false) : *
      {
         setScale(targScale + param1,param2);
      }
      
      public static function targToFollow() : void
      {
         var _loc1_:Boner = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(following && World.followObj != null && !World.followObj.isDestroyed && !World.currentLevel.inEditor)
         {
            cObject.camera_offset_car_x_targ = cObject.camera_offset_car_x_default;
            if(World.currentLevel != null && World.currentLevel.goingLeft)
            {
               cObject.camera_offset_car_x_targ = cObject.camera_offset_car_x_default + 160;
            }
            if(World.followObj != null && World.followObj.bodyParts.length > 0)
            {
               _loc1_ = World.followObj.bodyParts[0];
               if(World.currentLevel != null && World.currentLevel.inEditor)
               {
                  cObject.camera_offset_car_x = 0;
                  cObject.camera_offset_car_x_targ = 0;
               }
               cObject.camera_offset_car_x = cObject.camera_offset_car_x + (cObject.camera_offset_car_x_targ - cObject.camera_offset_car_x) / 10;
               _loc2_ = _loc1_.position.x * World.gameScale - cObject.camera_offset_car_x / camScale;
               _loc3_ = _loc1_.position.y * World.gameScale - cObject.camera_offset_car_y / camScale;
               if(!bossLocked)
               {
                  if(World.currentLevel.goingLeft)
                  {
                     if(_loc2_ < Camera.followX)
                     {
                        targX = _loc2_;
                     }
                  }
                  else if(_loc2_ > Camera.followX)
                  {
                     targX = _loc2_;
                  }
                  targY = _loc3_;
               }
               if(World.currentLevel != null && World.currentLevel.inEditor)
               {
                  targX = _loc2_;
               }
               targX = _loc2_;
            }
         }
      }
      
      public static function applyRectlimits() : void
      {
         var _loc1_:* = undefined;
         if(!World.currentLevel.allowWrapping)
         {
            if(!World.currentLevel.inEditor)
            {
               if(World.currentLevel.goingLeft)
               {
                  if(targX > LevelUtils.highestX)
                  {
                     targX = LevelUtils.highestX;
                  }
                  if(followX > LevelUtils.highestX)
                  {
                     followX = LevelUtils.highestX;
                  }
               }
               else
               {
                  if(targX < LevelUtils.highestX)
                  {
                     targX = LevelUtils.highestX;
                  }
                  if(followX < LevelUtils.highestX)
                  {
                     followX = LevelUtils.highestX;
                  }
               }
            }
            if(targX < 0)
            {
               targX = 0;
               followX = targX;
            }
            _loc1_ = SpriteUtils.groundClips.length * 2800;
            if(targX > _loc1_ - scaledWidth)
            {
               targX = _loc1_ - scaledWidth;
               followX = targX;
            }
         }
         if(targY > GroundUtils.sectionHeight - scaledHeight)
         {
            targY = GroundUtils.sectionHeight - scaledHeight;
            followY = targY;
         }
         targY = 0;
         followY = 0;
         if(World.currentLevel.scrollingBackground)
         {
            backgroundX = Camera.followX * 0.1 * 0.45 % 1400;
            backgroundX2 = Camera.followX * 0.2 * 0.5;
            backgroundX3 = Camera.followX * 0.3 * 0.5;
            backgroundX4 = Camera.followX * 0.4 * 0.5;
            if(World.currentLevel.yScrollBackground)
            {
               backgroundY = followY * 0.5 + World.currentLevel.yScrollBackgroundOffset;
               backgroundY2 = followY * 0.5 + World.currentLevel.yScrollBackgroundOffset2;
               if(backgroundY < 0)
               {
                  backgroundY = 0;
               }
               if(backgroundY > GroundUtils.sectionHeight - global.gameHeight)
               {
                  backgroundY = GroundUtils.sectionHeight - global.gameHeight;
               }
               if(backgroundY2 < 0)
               {
                  backgroundY2 = 0;
               }
               if(backgroundY2 > GroundUtils.sectionHeight - global.gameHeight)
               {
                  backgroundY2 = GroundUtils.sectionHeight - global.gameHeight;
               }
            }
            else
            {
               backgroundY = 0;
               backgroundY2 = 0;
            }
         }
         else
         {
            backgroundX = 0;
            backgroundY = 0;
            backgroundX2 = 0;
            backgroundY2 = 0;
         }
      }
      
      public static function updateMouseTranslation() : void
      {
         if(GameMode.gameMode != null)
         {
            mouseTransX = (GameMode.gameMode.mouseX / camScale + followX) / World.gameScale;
            mouseTransY = (GameMode.gameMode.mouseY / camScale + followY) / World.gameScale;
         }
      }
   }
}
