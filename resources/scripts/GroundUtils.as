package
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import nape.geom.Vec2;
   import nape.phys.BodyType;
   import nape.shape.*;
   import objects.cObject;
   
   public class GroundUtils
   {
      
      public static var sectionWidth:int = 2800;
      
      public static var sectionHeight:int = 960;
      
      public static var numSections:int = 8;
      
      public static var blocksPerSection:int = 20;
      
      public static var blockWidth:int = sectionWidth / blocksPerSection;
      
      public static var ground:Boner;
      
      public static var currentSection:int = 0;
      
      public static var lastSection:int = 0;
      
      public static var currentBlock:int = 0;
      
      public static var lastBlock:int = 0;
      
      public static var carBlock:int = 0;
      
      public static var lastCarBlock:int = 0;
      
      public static var carSection:int = 0;
      
      public static var lastCarSection:int = 0;
      
      public static var groundIndex:int = -1;
      
      public static var groundShapeList:Vector.<Shape> = new Vector.<Shape>();
      
      public static var groundOnlyString:String = "";
      
      public static var groundBrick:Shape = null;
      
      public static const use_chains:Boolean = false;
      
      public static var streamingFixtureList:Array;
      
      public static const oneOver:Number = 1 / World.gameScale;
      
      public static var ground_depth:Number = 5 * World.gameScale;
       
      
      public function GroundUtils()
      {
         super();
      }
      
      public static function update() : void
      {
         currentBlock = Math.floor(Camera.followX / (sectionWidth / 20));
         currentSection = Math.floor(Camera.followX / sectionWidth);
         if(World.followObj != null)
         {
            carBlock = Math.floor(World.followObj.currentX * World.gameScale / (sectionWidth / blocksPerSection));
            carSection = Math.floor(World.followObj.currentX * World.gameScale / sectionWidth);
         }
         else
         {
            carBlock = 0;
            carSection = 0;
         }
         if(currentBlock != lastBlock && World.currentLevel.preloadGroundSections == false)
         {
            if(World.currentLevel.inEditor || !(World.followObj != null && World.followObj.laps > 0))
            {
               SpriteUtils.drawBlock(currentBlock + 5);
            }
         }
         lastSection = currentSection;
         lastBlock = currentBlock;
         lastBlock = currentBlock;
         lastCarBlock = carBlock;
      }
      
      public static function resetGround() : void
      {
         if(ground != null)
         {
            EntUtils.destroyBody(ground);
         }
         BoxUtils.noAdd = true;
         ground = BoxUtils.NewBox(0,0,1,1,0,false,Filters.ground,Filters.groundMask);
         ground.type = BodyType.STATIC;
         ground.userData.isGround = true;
         ground.userData.actualGround = true;
         ground.isGround = true;
      }
      
      public static function setGround(param1:int) : *
      {
         resetGround();
         groundIndex = param1;
      }
      
      public static function traceTrackBitmaps() : void
      {
         var _loc1_:Boner = null;
         if(World.currentLevel.myID >= Level.LEVEL_1)
         {
            SpriteUtils.gameClip.scrollRect = null;
            _loc1_ = Composition.gameClipToBody(SpriteUtils.gameClip,0,new Vec2(32,32),new Vec2());
            _loc1_.position = new Vec2();
            _loc1_.userData.isGround = true;
            _loc1_.isGround = true;
            _loc1_.type = BodyType.STATIC;
            _loc1_.space = World.m_world;
         }
      }
      
      public static function traceTrackBitmap(param1:BitmapData, param2:Vec2) : void
      {
         var _loc3_:Boner = Composition.bitmapToBody(param1,0,new Vec2(82,82),param2);
         _loc3_.position = new Vec2();
         _loc3_.userData.isGround = true;
         _loc3_.type = BodyType.STATIC;
         _loc3_.space = World.m_world;
      }
      
      public static function traceTrack(param1:DisplayObject) : void
      {
         var _loc2_:DisplayObject = param1;
         var _loc3_:Boner = Composition.graphicToBody(_loc2_,new Vec2(12,12));
         _loc3_.position = new Vec2();
         _loc3_.type = BodyType.STATIC;
         _loc3_.space = World.m_world;
      }
      
      public static function setGroundFriction(param1:Number = 1) : *
      {
         var _loc3_:Shape = null;
         var _loc2_:int = 0;
         while(_loc2_ < groundShapeList.length)
         {
            _loc3_ = groundShapeList[_loc2_];
            _loc3_.material.dynamicFriction = param1;
            _loc2_++;
         }
      }
      
      public static function checkStreamingGround() : void
      {
         if(World.currentLevel.streamingGround && !World.currentLevel.inEditor)
         {
            GroundUtils.loadGroundChain_Streaming();
         }
      }
      
      public static function loadGroundChain_Streaming() : void
      {
         var _loc4_:int = 0;
         var _loc5_:Vec2 = null;
         var _loc6_:Vec2 = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Shape = null;
         var _loc11_:Shape = null;
         var _loc1_:String = groundOnlyString;
         if(streamingFixtureList.length > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < streamingFixtureList.length)
            {
               if(streamingFixtureList[_loc4_] != null)
               {
                  streamingFixtureList[_loc4_].body = null;
               }
               _loc4_++;
            }
         }
         streamingFixtureList = [];
         _loc1_ = groundOnlyString;
         var _loc2_:Array = _loc1_.split("|");
         _loc2_[0] = "0,1000";
         _loc2_[_loc2_.length - 1] = "14000,1000";
         var _loc3_:Array = new Array(_loc2_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length - 2)
         {
            _loc5_ = vecFromstring(_loc2_[_loc4_]);
            _loc6_ = vecFromstring(_loc2_[_loc4_ + 1]);
            _loc7_ = GroundUtils.sectionHeight / World.gameScale;
            if(World.currentLevel.allowWrapping)
            {
               _loc5_.x = _loc5_.x + _loc7_;
               _loc6_.x = _loc6_.x + _loc7_;
            }
            _loc8_ = Camera.followX + cObject.camera_offset_car_x / Camera.camScale;
            _loc9_ = 30 + (!!World.currentLevel.allowWrapping?_loc7_:0);
            if(Math.abs(_loc5_.x - _loc8_ * oneOver) <= cObject.object_freeze_distance + 30 / Camera.camScale || _loc5_.x < _loc9_)
            {
               if(!(_loc5_.x == _loc6_.x && _loc5_.y == _loc6_.y))
               {
                  if(!(_loc5_.y >= 60 && _loc6_.y >= 60))
                  {
                     if(use_chains)
                     {
                        _loc10_ = BoxUtils.defineShape(1,true,[_loc5_,_loc6_],Filters.ground,Filters.groundMask);
                        _loc10_.body = ground;
                        streamingFixtureList.push(_loc10_);
                     }
                     else
                     {
                        _loc11_ = BoxUtils.defineShape(1,true,[_loc5_.x * World.gameScale,(_loc5_.y + ground_depth) * World.gameScale,_loc5_.x * World.gameScale,_loc5_.y * World.gameScale,_loc6_.x * World.gameScale,_loc6_.y * World.gameScale,_loc6_.x * World.gameScale,_loc6_.y * World.gameScale + ground_depth],Filters.ground,Filters.groundMask);
                        _loc11_.body = ground;
                        streamingFixtureList.push(_loc11_);
                     }
                  }
               }
            }
            _loc4_++;
         }
      }
      
      public static function approximateGround(param1:Number) : Number
      {
         var _loc8_:Vec2 = null;
         var _loc2_:Number = param1;
         if(World.currentLevel.allowWrapping)
         {
            _loc2_ = _loc2_ - GroundUtils.sectionHeight / World.gameScale;
         }
         var _loc3_:Array = groundOnlyString.split("|");
         var _loc4_:int = -1;
         var _loc5_:Number = -1;
         var _loc6_:Number = -1;
         var _loc7_:int = 0;
         while(_loc7_ < _loc3_.length - 2)
         {
            _loc8_ = vecFromstring(_loc3_[_loc7_]);
            if(pd(_loc8_.x,_loc2_) < _loc5_ || _loc5_ == -1)
            {
               _loc4_ = _loc7_;
               _loc5_ = pd(_loc8_.x,_loc2_);
               _loc6_ = _loc8_.y;
            }
            _loc7_++;
         }
         return _loc6_;
      }
      
      private static function pd(param1:Number, param2:Number) : Number
      {
         return Math.abs(param1 - param2);
      }
      
      public static function loadGroundChain(param1:String) : void
      {
         var _loc5_:Vec2 = null;
         var _loc6_:Vec2 = null;
         var _loc7_:Polygon = null;
         streamingFixtureList = [];
         var _loc2_:Array = param1.split("|");
         _loc2_[0] = "0,1000";
         _loc2_[_loc2_.length - 1] = "14000,1000";
         var _loc3_:Array = new Array(_loc2_.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length - 2)
         {
            _loc5_ = vecFromstring(_loc2_[_loc4_]);
            _loc6_ = vecFromstring(_loc2_[_loc4_ + 1]);
            if(!(_loc5_.x == _loc6_.x && _loc5_.y == _loc6_.y))
            {
               _loc7_ = BoxUtils.defineShape(1,true,[_loc5_,_loc6_],Filters.ground,Filters.groundMask);
               _loc7_.body = ground;
               streamingFixtureList.push(_loc7_);
            }
            _loc4_++;
         }
         BoxUtils.defineShape(1,true,[0,0,5,0,5,960,0,960],Filters.ground,Filters.groundMask).body = ground;
      }
      
      public static function loadGroundShapes(param1:String) : void
      {
         var _loc4_:Vec2 = null;
         var _loc5_:Vec2 = null;
         var _loc6_:Number = NaN;
         var _loc2_:Array = param1.split("|");
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length - 2)
         {
            _loc4_ = vecFromstringAsPixels(_loc2_[_loc3_]);
            _loc5_ = vecFromstringAsPixels(_loc2_[_loc3_ + 1]);
            _loc6_ = World.gameScale * 80;
            _loc4_.muleq(2);
            _loc5_.muleq(2);
            if(_loc5_.x > GroundUtils.sectionWidth * GroundUtils.numSections - 60)
            {
               _loc5_.x = _loc5_.x + 220;
            }
            if(_loc4_.x >= 400)
            {
               if(_loc4_.x != _loc5_.x && !(_loc4_.y == global.gameHeight && _loc5_.y == global.gameHeight))
               {
                  BoxUtils.defineShape(1,true,[_loc4_.x,_loc4_.y + _loc6_,_loc4_.x,_loc4_.y,_loc5_.x,_loc5_.y,_loc5_.x,_loc5_.y + _loc6_],Filters.ground,Filters.groundMask,1).body = ground;
               }
            }
            _loc3_++;
         }
      }
      
      public static function vecFromstring(param1:String) : Vec2
      {
         var _loc2_:Array = param1.split(",");
         return new Vec2(int(_loc2_[0]) * oneOver,int(_loc2_[1]) * oneOver);
      }
      
      public static function vecFromstringAsPixels(param1:String) : Vec2
      {
         var _loc2_:Array = param1.split(",");
         return new Vec2(int(_loc2_[0]),int(_loc2_[1]));
      }
   }
}
