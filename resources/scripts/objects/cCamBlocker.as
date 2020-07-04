package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public class cCamBlocker extends slugObject
   {
       
      
      public var part_main:Boner;
      
      public var activated:Boolean = false;
      
      public var spent:Boolean = false;
      
      public var flippity:Boolean = false;
      
      public function cCamBlocker(param1:Number, param2:Number, param3:GameMode, param4:Number = 0, param5:cObject = null)
      {
         super(param1,param2,param3,param4);
         this.createBody();
         this.createGraphics();
         this.setGraphics();
         postCreate();
      }
      
      override public function getStats() : void
      {
         var _loc1_:customFont = null;
         super.getStats();
         isBreakable = false;
         isBounceTrigger = false;
         isAlwaysEnabled = false;
         myBodyClip = new MovieClip();
         if(slugObject.showNames)
         {
            _loc1_ = new customFont(12,this.getTypeStringLol(),true);
            myBodyClip.addChild(_loc1_);
         }
         dealsTouchDamage = -1;
         touchDamageDelay = -1;
         hitRect = new Rectangle(0,0,20,20);
      }
      
      public function getTypeStringLol() : String
      {
         return "CAM";
      }
      
      public function createBody() : void
      {
         this.part_main = BoxUtils.NewBox(x,y,hitRect.width,hitRect.height,1,true,Filters.fuckall,Filters.fuckallMask);
         lastPart = this.part_main;
         addPart(this.part_main);
         bodyParts[0].gravMassScale = 0;
      }
      
      override public function subTick() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         var _loc3_:cObject = null;
         super.subTick();
         this.flippity = !this.flippity;
         if(!World.currentLevel.inEditor)
         {
            if(!this.activated && this.flippity && !this.spent)
            {
               if(currentX > LevelUtils.highestX && currentX < LevelUtils.highestX + global.gameWidth)
               {
                  this.activated = true;
                  Camera.setFollowing(false);
                  this.spent = true;
               }
            }
            if(this.activated)
            {
               _loc1_ = false;
               _loc2_ = 0;
               while(_loc2_ < World.currentLevel.levelObjects.length)
               {
                  _loc3_ = World.currentLevel.levelObjects[_loc2_];
                  if(_loc3_ != null && _loc3_.sluggable)
                  {
                     if(_loc3_.slugCast.is_camlock_enemy)
                     {
                        if(!_loc3_.flagged && _loc3_.flaggedTimer == -1)
                        {
                           if(_loc3_.currentX > LevelUtils.highestX && _loc3_.currentX < LevelUtils.highestX + global.gameWidth || _loc3_ is cAICopter && _loc3_.slugCast.slug_health > 0 && (_loc3_ as cAICopter).hasBeenInRange)
                           {
                              if(_loc3_ is cAICopter)
                              {
                              }
                              if(_loc3_ is cAICopter)
                              {
                              }
                              _loc1_ = true;
                           }
                        }
                     }
                  }
                  _loc2_++;
               }
               if(!_loc1_)
               {
                  Camera.setFollowing(true);
                  this.activated = false;
               }
            }
            if(!World.currentLevel.inEditor && !this.activated && !(this is cCamBlockerMini))
            {
               if(!GameMode.completed && !GameMode.goal && !GameMode.failed)
               {
                  if(World.followObj != null)
                  {
                     if(World.currentLevel.goingLeft)
                     {
                        if(World.followObj.currentX < currentX + 100)
                        {
                           GameMode.goal = true;
                        }
                     }
                     else if(World.followObj.currentX > currentX - 100)
                     {
                        GameMode.goal = true;
                     }
                  }
               }
            }
         }
      }
      
      public function createGraphics() : void
      {
         setData(bodyParts[0],myBodyClip);
      }
      
      public function setGraphics() : void
      {
      }
   }
}
