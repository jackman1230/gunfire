package
{
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import nape.geom.Vec2;
   import objects.*;
   
   public class LevelUtils
   {
      
      public static var gMode:GameMode;
      
      public static var reloadPending:Boolean = false;
      
      public static var startPoint:Vec2 = null;
      
      public static var lastLevelIndex:int = 0;
      
      public static var levelCache:int = 0;
      
      public static var reloadingSameLevel:Boolean = false;
      
      public static var l1:Boolean = false;
      
      public static var leftBlocker:Boner;
      
      public static var highestX:int = 0;
       
      
      public function LevelUtils()
      {
         super();
      }
      
      public static function initLevel(param1:int, param2:int = 0) : *
      {
         if(param1 == Level.LEVEL_2)
         {
            GameMode.secondVehicleUnlocked = true;
            Serialiser.saveStats();
         }
         if(param1 == Level.LEVEL_4)
         {
            GameMode.thirdVehicleUnlocked = true;
            Serialiser.saveStats();
         }
         if(param1 >= Level.LEVEL_1 && param2 == Level.MODE_NORMAL)
         {
            levelCache = param1;
            re_initLevel(param1,param2);
         }
         else
         {
            re_initLevel(param1,param2);
         }
      }
      
      public static function loadLevelCache() : *
      {
         re_initLevel(levelCache);
      }
      
      public static function re_initLevel(param1:int, param2:int = 0) : *
      {
         if(World.currentLevel != null)
         {
            lastLevelIndex = World.currentLevel.myID;
         }
         reloadPending = false;
         gMode.worldLocked = true;
         GameMode.playing = false;
         gMode.cleanup();
         var _loc3_:Level = Level.createLevel(param1,param2);
         World.currentLevel = _loc3_;
         reloadingSameLevel = l1;
         l1 = true;
         if(reloadingSameLevel)
         {
            World.currentLevel.staggeredLoading = false;
         }
         loadLevelAssets(_loc3_);
         World.m_world.gravity = new Vec2(0,_loc3_.gravity);
         if(World.currentLevel.controlable)
         {
            MochiConnect.staticSelf.startPlay();
         }
         if(!World.currentLevel.staggeredLoading)
         {
            if(!World.currentLevel.inEditor)
            {
               gMode.playPressed();
            }
            gMode.worldLocked = false;
         }
         else
         {
            gMode.showLoadingScreen();
         }
      }
      
      public static function coinTest() : *
      {
         var _loc1_:int = 10;
         var _loc2_:int = 0;
         while(_loc2_ < 40)
         {
            LevelUtils.levelOb(new cCoin(130 + _loc1_,5,GameMode.gameMode,0));
            _loc1_ = _loc1_ + 30;
            _loc2_++;
         }
      }
      
      public static function getClass(param1:Object) : Class
      {
         return Class(getDefinitionByName(getQualifiedClassName(param1)));
      }
      
      public static function updateObjects() : *
      {
         var _loc1_:int = 0;
         var _loc2_:Level = World.currentLevel;
         if(_loc2_ != null && _loc2_.levelObjects != null && _loc2_.levelObjects.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < _loc2_.levelObjects.length)
            {
               if(!GameMode.gameMode.worldLocked && !World.stopTicking)
               {
                  _loc2_.levelObjects[_loc1_].tick(World.followObj);
               }
               if(_loc2_.levelObjects[_loc1_].flagged)
               {
                  if(_loc2_.levelObjects[_loc1_].slugCast != null)
                  {
                     _loc2_.levelObjects[_loc1_].slugCast.doScore();
                  }
                  destroyObject(_loc2_.levelObjects[_loc1_]);
               }
               _loc1_++;
            }
         }
      }
      
      public static function clearLeftBlocker() : void
      {
         if(leftBlocker == null)
         {
         }
         if(World.currentLevel.goingLeft)
         {
            highestX = 21000;
            Camera.followX = 21000;
            Camera.targX = 21000;
         }
         else
         {
            highestX = 0;
         }
         Camera.setFollowing(false);
      }
      
      public static function loadLevelAssets(param1:Level) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Class = null;
         var _loc6_:ByteArray = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc2_:int = param1.load_image_id;
         clearLeftBlocker();
         GroundUtils.setGround(_loc2_);
         if(!LevelUtils.reloadingSameLevel)
         {
            SpriteUtils.makeCanvases(_loc2_);
            if(World.drawDebugShapes)
            {
               SpriteUtils.addDebugger();
            }
            SpriteUtils.fillCanvases(_loc2_);
            SpriteUtils.drawLevelDetailBitmapped();
         }
         if(World.currentLevel.singleGroundLine)
         {
            GroundUtils.groundBrick = BoxUtils.defineShape(0,true,[0,480,19600,480,19600,580,0,580],Filters.ground,Filters.groundMask);
            GroundUtils.groundBrick.body = GroundUtils.ground;
         }
         else
         {
            _loc4_ = param1.load_phys_id;
            _loc5_ = PhysFiles.physSections[0];
            if(_loc5_ != null)
            {
               _loc6_ = new _loc5_() as ByteArray;
               _loc7_ = _loc6_.toString();
               _loc8_ = _loc7_.split("~")[0];
               loadObjectString(_loc8_);
               _loc9_ = _loc7_.split("~")[1];
               GroundUtils.loadGroundShapes(_loc9_);
            }
            if(param1.levelString != null)
            {
               loadObjectString(param1.levelString);
            }
         }
         var _loc3_:int = GroundUtils.sectionWidth * GroundUtils.numSections;
         BoxUtils.defineShape(1,true,[0,0,5,0,5,960,0,960],Filters.ground,Filters.groundMask,1,false,1).body = GroundUtils.ground;
         BoxUtils.defineShape(1,true,[0,400,5000,400,2000,450,0,450],Filters.ground,Filters.groundMask,1,false,1).body = GroundUtils.ground;
         BoxUtils.defineShape(1,true,[0,365,300,365,300,450,0,450],Filters.ground,Filters.groundMask,1,false,1).body = GroundUtils.ground;
         GroundUtils.ground.space = World.m_world;
      }
      
      public static function loadObjectString(param1:String = null) : *
      {
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:Class = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:cObject = null;
         var _loc2_:Array = param1.split("|");
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_].split(",");
            _loc5_ = _loc4_[0];
            if(gMode.spawnHandler.iconTypes.indexOf(_loc5_) > -1)
            {
               _loc6_ = Class(getDefinitionByName("objects::" + _loc5_));
               _loc7_ = Number(_loc4_[1]) * 16;
               _loc8_ = Number(_loc4_[2]) * 16;
               _loc9_ = 0;
               if(_loc4_.length >= 3)
               {
                  _loc9_ = Number(_loc4_[3]);
               }
               if(isNaN(_loc9_))
               {
                  _loc9_ = 0;
               }
               if(!World.currentLevel.inEditor)
               {
                  if(_loc5_ == "cCarryable")
                  {
                     _loc7_ = _loc7_ + 1;
                  }
               }
               _loc10_ = new _loc6_(_loc7_,_loc8_,GameMode.gameMode,_loc9_) as cObject;
               levelOb(_loc10_);
               if(_loc5_ == "cCar")
               {
                  World.followObj = _loc10_;
               }
            }
            _loc3_++;
         }
      }
      
      public static function generateObjectString() : String
      {
         var _loc4_:cObject = null;
         var _loc1_:String = "|";
         var _loc2_:String = "";
         LevelUtils.findCar();
         if(World.followObj != null && World.followObj is cCar)
         {
            _loc1_ = _loc1_ + getQualifiedClassName(World.followObj).replace("objects::","");
            _loc1_ = _loc1_ + locationString(World.followObj);
         }
         else
         {
            _loc2_ = "";
         }
         var _loc3_:int = 0;
         while(_loc3_ < World.currentLevel.levelObjects.length)
         {
            _loc4_ = World.currentLevel.levelObjects[_loc3_];
            if(_loc4_ != null)
            {
               if(_loc4_ != World.followObj)
               {
                  _loc1_ = _loc1_ + getQualifiedClassName(_loc4_).replace("objects::","");
                  _loc1_ = _loc1_ + locationString(_loc4_);
               }
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      private static function locationString(param1:cObject) : String
      {
         var _loc2_:String = "," + (param1.currentX / 16).toPrecision(4) + "," + (param1.currentY / 16).toPrecision(4);
         _loc2_ = _loc2_ + ("," + param1.placedAngle.toPrecision(4));
         return _loc2_ + "|";
      }
      
      public static function generateLevelString() : String
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = [0,0,0,0,0,0,0,0,0,0];
         var _loc4_:* = "";
         var _loc5_:String = "";
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         var _loc8_:* = World.currentLevel.levelObjects.length;
         if(World.followObj != null)
         {
            _loc8_--;
         }
         _loc3_[0] = "^";
         _loc3_[1] = GroundUtils.groundIndex;
         _loc3_[2] = _loc8_;
         _loc3_[3] = "^";
         _loc1_ = 0;
         _loc2_ = -1;
         _loc4_ = "";
         _loc5_ = "";
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            _loc4_ = _loc4_ + String(_loc3_[_loc1_]);
            _loc4_ = _loc4_ + ",";
            _loc1_++;
         }
         _loc4_ = _loc4_ + "|";
         LevelUtils.findCar();
         if(World.followObj != null && World.followObj is cCar)
         {
            _loc5_ = getQualifiedClassName(World.followObj);
            _loc5_ = _loc5_.replace("objects::","");
         }
         else
         {
            _loc5_ = "";
         }
         if(gMode.spawnHandler.iconTypes.indexOf(_loc5_) > -1)
         {
            _loc4_ = _loc4_ + (_loc5_ + locationString(World.followObj));
            _loc6_ = World.followObj.placedX;
            _loc7_ = World.followObj.placedY;
         }
         else
         {
            _loc4_ = _loc4_ + "X,X,X,X|";
         }
         _loc1_ = 0;
         while(_loc1_ < World.currentLevel.levelObjects.length)
         {
            _loc2_ = 1;
            _loc5_ = getQualifiedClassName(World.currentLevel.levelObjects[_loc1_]);
            _loc5_ = _loc5_.replace("objects::","");
            _loc2_ = gMode.spawnHandler.iconTypes.indexOf(_loc5_);
            if(_loc2_ > -1 && World.currentLevel.levelObjects[_loc1_] != World.followObj && !(World.currentLevel.levelObjects[_loc1_] is cCar))
            {
               _loc4_ = _loc4_ + _loc5_ + locationString(World.currentLevel.levelObjects[_loc1_]);
            }
            _loc1_++;
         }
         return _loc4_;
      }
      
      public static function unfreezeObjects() : *
      {
         var _loc2_:cObject = null;
         var _loc1_:Level = World.currentLevel;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.levelObjects.length)
         {
            _loc2_ = _loc1_.levelObjects[_loc3_];
            if(!_loc2_.outOfSight)
            {
               _loc2_.unfreeze();
            }
            _loc2_.removeSensor();
            _loc3_++;
         }
      }
      
      public static function levelOb(param1:cObject) : *
      {
         World.currentLevel.levelObjects.push(param1);
         (param1 as cObject).editorDraggable = true;
         if(World.followObj == null && param1 is cCar && !World.currentLevel.inEditor)
         {
            World.followObj = param1;
            Migrate.fo = param1;
         }
      }
      
      public static function deleteLast() : *
      {
         if(gMode.lastObject != null)
         {
            destroyObject(gMode.lastObject,null);
         }
         else
         {
            SliderHandler.addSlider(" Delete ");
         }
         gMode.lastObject = null;
      }
      
      public static function destroyObject(param1:cObject, param2:Vector.<cObject> = null) : *
      {
         var _loc3_:Level = World.currentLevel;
         if(_loc3_.levelObjects.indexOf(param1) > -1)
         {
            _loc3_.levelObjects.splice(_loc3_.levelObjects.indexOf(param1),1);
         }
         if(param1 != null)
         {
            param1.destroy();
         }
         if(param1 == World.followObj)
         {
            World.followObj = null;
         }
      }
      
      public static function destroyObjects() : void
      {
         var _loc1_:Level = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(World.currentLevel != null)
         {
            _loc1_ = World.currentLevel;
            _loc2_ = World.currentLevel.levelObjects.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               (_loc1_.levelObjects[0] as cObject).destroy();
               _loc1_.levelObjects.splice(0,1);
               _loc3_++;
            }
            _loc1_.levelObjects = new Vector.<cObject>();
         }
      }
      
      public static function findCar() : *
      {
         World.followObj = null;
         var _loc1_:int = 0;
         while(_loc1_ < World.currentLevel.levelObjects.length)
         {
            if(World.currentLevel.levelObjects[_loc1_] != null && World.currentLevel.levelObjects[_loc1_] is cCar)
            {
               World.followObj = World.currentLevel.levelObjects[_loc1_];
            }
            _loc1_++;
         }
      }
      
      public static function rotate(param1:Boolean) : *
      {
         var _loc2_:Number = 0.1;
         if(param1)
         {
            _loc2_ = -0.3;
         }
         else
         {
            _loc2_ = 0.3;
         }
         _loc2_ = _loc2_ * 0.1;
         var _loc3_:cObject = gMode.lastObject;
         if(gMode.lastObject != null)
         {
            _loc3_.placedAngle = _loc3_.placedAngle + _loc2_;
            restoreObj(_loc3_,null);
         }
      }
      
      public static function copyData(param1:cObject, param2:cObject) : *
      {
         var _loc3_:Level = World.currentLevel;
         if(_loc3_.inEditor)
         {
            param1.originalX = param1.placedX;
            param1.originalY = param1.placedY;
            param1.originalAngle = param1.placedAngle;
         }
         param2.originalX = param1.originalX;
         param2.originalY = param1.originalY;
         param2.placedX = param1.placedX;
         param2.placedY = param1.placedY;
         param2.originalAngle = param1.originalAngle;
         param2.placedAngle = param1.placedAngle;
         param2.laps = param1.laps;
         if(param1 == World.followObj && !World.currentLevel.inEditorPreview)
         {
            World.followObj = param2;
         }
         if(param1 is cCar)
         {
            (param2 as cCar).setGraphics();
         }
      }
      
      public static function restoreObj(param1:cObject, param2:String = null) : Boolean
      {
         var _loc3_:* = undefined;
         var _loc4_:Class = null;
         var _loc5_:Class = null;
         _loc4_ = null;
         _loc5_ = null;
         _loc3_ = null;
         _loc4_ = getClass(param1);
         if(param2 != null)
         {
            _loc4_ = getDefinitionByName("objects::" + param2) as Class;
         }
         _loc3_ = new _loc4_(param1.placedX,param1.placedY,gMode,param1.placedAngle);
         copyData(param1,_loc3_);
         LevelUtils.levelOb(_loc3_);
         gMode.lastObject = _loc3_;
         if(!(gMode.shiftDown && World.currentLevel.inEditor))
         {
            LevelUtils.destroyObject(param1,null);
         }
         return true;
      }
      
      public static function objectChange(param1:Boolean) : *
      {
         var _loc2_:Class = null;
         var _loc3_:String = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc4_:int = -1;
         _loc5_ = 0;
         _loc6_ = 0;
         var _loc7_:Level = World.currentLevel;
         if(gMode.lastObject != null)
         {
            _loc3_ = getQualifiedClassName(gMode.lastObject);
            _loc3_ = _loc3_.replace("objects::","");
            _loc4_ = gMode.spawnHandler.iconTypes.indexOf(_loc3_);
            if(_loc4_ > -1)
            {
               if(param1)
               {
                  _loc4_++;
               }
               else
               {
                  _loc4_--;
               }
               if(_loc4_ < 0)
               {
                  _loc4_ = gMode.spawnHandler.iconTypes.length - 1;
               }
               if(_loc4_ == gMode.spawnHandler.iconTypes.length)
               {
                  _loc4_ = 0;
               }
               _loc3_ = gMode.spawnHandler.iconTypes[_loc4_];
               _loc2_ = Class(getDefinitionByName("objects::" + _loc3_));
               _loc5_ = gMode.lastObject.placedX;
               _loc6_ = gMode.lastObject.placedY;
               gMode.lastObject.destroy();
               destroyObject(gMode.lastObject);
               levelOb(gMode.lastObject = new _loc2_(_loc5_,_loc6_,gMode));
            }
            else
            {
               gMode.lastObject = null;
            }
         }
      }
   }
}
