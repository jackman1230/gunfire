package
{
   import com.bit101.display.*;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import nape.geom.Vec2;
   import nape.util.BitmapDebug;
   
   public class SpriteUtils
   {
      
      public static var gameClip:BigAssCanvas;
      
      public static var transferClip:BigAssCanvas;
      
      public static var bgClip:Sprite;
      
      public static var bg2Clip:Sprite;
      
      public static var bg3Clip:Sprite;
      
      public static var bg4Clip:Sprite;
      
      public static var miniLevel:BigAssCanvas;
      
      public static var debugMode:BitmapDebug;
      
      public static var blocksDrawn:Array = new Array();
      
      public static var addedList:Array = [];
      
      public static var groundClips:Array = new Array(new Sprite(),new Sprite(),new Sprite(),new Sprite(),new Sprite(),new Sprite(),new Sprite());
      
      public static var decClips:Array = new Array(new Sprite(),new Sprite(),new Sprite(),new Sprite(),new Sprite(),new Sprite(),new Sprite());
       
      
      public function SpriteUtils()
      {
         super();
      }
      
      public static function setHandcursorActive(param1:DisplayObject, param2:Boolean, param3:uint = 0) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:DisplayObject = null;
         if(param1 is Sprite)
         {
         }
         if(param3-- == 0)
         {
            return;
         }
         if(param1 is DisplayObjectContainer)
         {
            _loc4_ = 0;
            while(_loc4_ < DisplayObjectContainer(param1).numChildren)
            {
               _loc5_ = DisplayObjectContainer(param1).getChildAt(_loc4_);
               setHandcursorActive(_loc5_,param2,param3);
               _loc4_++;
            }
         }
      }
      
      public static function drawLevelDetailBitmapped() : void
      {
      }
      
      public static function findYforX(param1:int) : *
      {
         var _loc6_:uint = 0;
         var _loc2_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:int = 100;
         while(_loc5_ < GroundUtils.sectionHeight - 100)
         {
            _loc6_ = SpriteUtils.gameClip.getPixel32(param1,_loc5_);
            if(_loc6_ > 4278190080 && !_loc4_)
            {
               _loc4_ = true;
               _loc2_ = _loc5_;
               break;
            }
            _loc5_ = _loc5_ + 4;
         }
         return _loc2_;
      }
      
      public static function drawLevelDetail() : void
      {
         var _loc4_:int = 0;
         var _loc11_:Vec2 = null;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:* = undefined;
         var _loc19_:* = undefined;
         var _loc20_:* = undefined;
         var _loc21_:* = undefined;
         var _loc22_:Vec2 = null;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Boolean = false;
         var _loc26_:Boolean = false;
         var _loc27_:* = undefined;
         var _loc28_:* = undefined;
         var _loc29_:int = 0;
         var _loc30_:MovieClip = null;
         var _loc31_:Matrix = null;
         var _loc32_:Vec2 = null;
         var _loc33_:ColorTransform = null;
         var _loc1_:Array = GroundUtils.groundOnlyString.split("|");
         var _loc2_:Vector.<Vec2> = new Vector.<Vec2>();
         var _loc3_:Vec2 = new Vec2(0,0);
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length - 2)
         {
            _loc11_ = GroundUtils.vecFromstring(_loc1_[_loc4_]);
            if(_loc11_.y < 960 / World.gameScale && (_loc3_.x != _loc11_.x || _loc3_.y != _loc11_.y || _loc4_ < 5))
            {
               _loc2_.push(_loc11_);
            }
            _loc4_++;
         }
         var _loc5_:Number = 1 - Math.random() * 0.2;
         var _loc6_:Number = 0;
         var _loc7_:Boolean = false;
         var _loc9_:Number = _loc2_.length - 1;
         if(_loc9_ > _loc2_.length - 1)
         {
            _loc9_ = _loc2_.length - 1;
         }
         var _loc10_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc9_)
         {
            _loc7_ = true;
            if(_loc4_ == 0)
            {
               _loc7_ = false;
            }
            if(_loc7_)
            {
               _loc10_ = _loc4_;
               _loc12_ = _loc2_[_loc4_].x;
               _loc13_ = _loc2_[_loc4_].y;
               _loc14_ = _loc2_[_loc4_ + 1].x;
               _loc15_ = _loc2_[_loc4_ + 1].y;
               _loc16_ = _loc14_ - _loc12_;
               _loc17_ = _loc15_ - _loc13_;
               _loc18_ = Math.PI * 2;
               _loc19_ = Math.PI * 0.5;
               _loc20_ = Math.PI * 0.4;
               _loc21_ = _loc18_ - _loc19_;
               _loc22_ = new Vec2(_loc16_,_loc17_);
               _loc23_ = Math.sqrt(_loc22_.lsq());
               _loc24_ = Math.atan2(_loc17_,_loc16_);
               while(_loc24_ > _loc18_)
               {
                  _loc24_ = _loc24_ - _loc18_;
               }
               while(_loc24_ < 0)
               {
                  _loc24_ = _loc24_ + _loc18_;
               }
               _loc25_ = false;
               _loc26_ = false;
               _loc27_ = false;
               _loc28_ = false;
               _loc29_ = Math.floor(Math.random() * 21) + 1;
               _loc30_ = new littlestar();
               _loc30_.gotoAndStop(_loc29_);
               _loc6_ = 0;
               switch(_loc29_)
               {
                  default:
                     _loc24_ = _loc24_;
                     _loc27_ = true;
                     break;
                  case 2:
                     _loc26_ = _loc25_;
                     break;
                  case 3:
                     _loc26_ = _loc25_;
                     _loc27_ = true;
                     break;
                  case 4:
                     _loc26_ = _loc25_;
                     _loc27_ = true;
                     break;
                  case 5:
                     _loc6_ = 100 + Math.random() * 100;
                     _loc28_ = true;
                     break;
                  case 6:
                     _loc6_ = 100 + Math.random() * 100;
                     _loc28_ = true;
                     break;
                  case 7:
                     _loc6_ = 100 + Math.random() * 100;
                     _loc28_ = true;
                     break;
                  case 8:
                     _loc6_ = 100 + Math.random() * 100;
                     _loc28_ = true;
                     break;
                  case 9:
                     _loc26_ = _loc25_;
                     break;
                  case 10:
                     _loc26_ = _loc25_ || _loc12_ < 400 || _loc13_ < 250;
                     _loc5_ = 1;
                     break;
                  case 11:
                     _loc5_ = 1;
                     _loc26_ = _loc25_ || _loc12_ < 400 || _loc13_ < 250;
                     break;
                  case 12:
                     _loc24_ = 0;
                     break;
                  case 13:
                     _loc26_ = _loc25_;
                     break;
                  case 14:
                     _loc24_ = 0;
                     _loc27_ = true;
                     break;
                  case 15:
                     _loc24_ = 0;
                     _loc27_ = true;
                     break;
                  case 16:
                     _loc24_ = 0;
                     _loc27_ = true;
                     break;
                  case 17:
                     _loc24_ = 0;
                     _loc26_ = _loc25_;
                     break;
                  case 18:
                     _loc24_ = 0;
                     break;
                  case 19:
                     _loc24_ = 0;
                     _loc26_ = _loc25_;
                     break;
                  case 20:
                     _loc24_ = 0;
                     _loc26_ = _loc25_;
                     break;
                  case 21:
                     _loc24_ = 0;
               }
               if(_loc13_ < 100)
               {
                  _loc26_ = true;
               }
               if(_loc13_ - _loc30_.height * 1.1 * _loc5_ < 0)
               {
                  _loc26_ = true;
               }
               if(_loc27_)
               {
                  if(Math.random() > 0.5)
                  {
                     _loc24_ = _loc24_ + Math.random() * 0.2;
                  }
                  else
                  {
                     _loc24_ = _loc24_ + Math.random() * -0.2;
                  }
               }
               _loc31_ = new Matrix(_loc5_,0,0,_loc5_);
               _loc32_ = _loc2_[_loc4_].copy();
               _loc31_.rotate(_loc24_);
               _loc31_.translate(_loc32_.x * World.gameScale,(_loc32_.y + _loc6_) * World.gameScale);
               _loc33_ = new ColorTransform(1,1 + Math.random() * 0.1,1,1);
               if(!_loc26_)
               {
                  if(_loc28_)
                  {
                     transferClip.draw(_loc30_,_loc31_,_loc33_,null,null,true);
                  }
               }
            }
            _loc4_++;
         }
      }
      
      public static function drawGrass() : *
      {
      }
      
      public static function makeCanvases(param1:Boolean = false, param2:Boolean = false) : *
      {
         clearBlocks();
         if(bgClip == null)
         {
            bgClip = new Sprite();
         }
         if(bg2Clip == null)
         {
            bg2Clip = new Sprite();
         }
         if(bg3Clip == null)
         {
            bg3Clip = new Sprite();
         }
         if(bg4Clip == null)
         {
            bg4Clip = new Sprite();
         }
         if(!GameMode.gameMode.contains(bgClip))
         {
            GameMode.gameMode.addChild(bgClip);
         }
         if(!GameMode.gameMode.contains(bg2Clip))
         {
            GameMode.gameMode.addChild(bg2Clip);
         }
         if(!GameMode.gameMode.contains(bg3Clip))
         {
            GameMode.gameMode.addChild(bg3Clip);
         }
         if(!GameMode.gameMode.contains(bg4Clip))
         {
            GameMode.gameMode.addChild(bg4Clip);
         }
         if(gameClip == null)
         {
            gameClip = new BigAssCanvas(GroundUtils.numSections * GroundUtils.sectionWidth,GroundUtils.sectionHeight,true);
         }
         else
         {
            gameClip.fillRect(new Rectangle(0,0,GroundUtils.numSections * GroundUtils.sectionWidth,GroundUtils.sectionHeight),0);
         }
         if(!GameMode.gameMode.contains(gameClip))
         {
            GameMode.gameMode.addChild(gameClip);
         }
         if(World.currentLevel != null && (World.currentLevel.allowWrapping || World.currentLevel.transferClip))
         {
            if(transferClip == null)
            {
               transferClip = new BigAssCanvas(GroundUtils.numSections * GroundUtils.sectionWidth,GroundUtils.sectionHeight,true);
               transferClip.x = 0;
               transferClip.y = 0;
            }
            else
            {
               transferClip.fillRect(new Rectangle(0,0,GroundUtils.numSections * GroundUtils.sectionWidth,GroundUtils.sectionHeight),0);
            }
            if(!GameMode.gameMode.contains(transferClip))
            {
               GameMode.gameMode.addChild(transferClip);
            }
         }
      }
      
      public static function fillCanvases(param1:int) : *
      {
         var _loc2_:int = 0;
         if(World.currentLevel.singleGroundClip)
         {
            groundClips = GroundLoader.getSingeGround();
         }
         else
         {
            groundClips = GroundLoader.getPanelsForIndex(param1);
            if(World.currentLevel.preloadGroundSections)
            {
               _loc2_ = 0;
               while(_loc2_ < groundClips.length)
               {
                  gameClip.draw(groundClips[_loc2_],new Matrix(2,0,0,2,GroundUtils.sectionWidth * _loc2_,0 + (param1 > 0?0:0)));
                  _loc2_++;
               }
            }
         }
         gameClip.mouseEnabled = false;
         if(!World.currentLevel.preloadGroundSections)
         {
            _loc2_ = 0;
            while(_loc2_ < 20)
            {
               drawBlock(_loc2_ + (!!World.currentLevel.allowWrapping?20:0));
               _loc2_++;
            }
         }
      }
      
      public static function setData(param1:Boner, param2:Sprite, param3:Boolean = false) : *
      {
         if(param1 != null && param2 != null)
         {
            param1.userData.sprite = param2;
            gameClip.addChild(param2);
            if(param3)
            {
               gameClip.setChildIndex(param2,1);
            }
            param2.cacheAsBitmap = true;
         }
      }
      
      public static function killData(param1:Boner) : *
      {
         if(param1 != null && param1.userData.sprite != null && gameClip.contains(param1.userData.sprite))
         {
            gameClip.removeChild(param1.userData.sprite);
            param1.userData.sprite = null;
         }
      }
      
      public static function update() : void
      {
         drawEdges();
         drawObjects();
         if(World.drawDebugShapes && debugMode != null && !gameClip.contains(debugMode.display))
         {
            gameClip.addChild(debugMode.display);
         }
      }
      
      public static function drawBlock(param1:int) : *
      {
         if(World.currentLevel.allowWrapping)
         {
            if(param1 > 19 && param1 < 39)
            {
               drawBlock(param1 + 20 * 5);
            }
            if(param1 > 99 && param1 < 120)
            {
               drawBlock(param1 - 20 * 5);
            }
         }
         var _loc2_:int = param1 * GroundUtils.blockWidth;
         var _loc3_:int = Math.floor(param1 / 20);
         var _loc4_:int = _loc3_ * GroundUtils.sectionWidth;
         var _loc5_:int = param1 % 20 * GroundUtils.blockWidth;
         var _loc6_:int = _loc3_;
         var _loc7_:Rectangle = new Rectangle(_loc4_ + _loc5_,0,GroundUtils.blockWidth,900);
         if(_loc6_ < groundClips.length)
         {
         }
         blocksDrawn[param1] = true;
      }
      
      public static function clearBlocks() : void
      {
         blocksDrawn = new Array();
      }
      
      public static function drawObjects() : void
      {
         var _loc2_:Boner = null;
         var _loc3_:Boner = null;
         var _loc1_:int = 0;
         while(_loc1_ < World.m_world.bodies.length)
         {
            _loc2_ = World.m_world.bodies.at(_loc1_) as Boner;
            if(_loc2_.userData.sprite is Sprite)
            {
               if(!_loc2_.userData.clipDisableRotation)
               {
                  if(_loc2_.userData.clipRotationSource != null)
                  {
                     _loc2_.userData.sprite.rotation = _loc2_.userData.clipRotationSource.rotation * (180 / Math.PI) % 360;
                  }
                  else
                  {
                     _loc2_.userData.sprite.rotation = _loc2_.rotation * (180 / Math.PI) % 360;
                  }
               }
               _loc3_ = _loc2_.userData.clipLocationSource != null?_loc2_.userData.clipLocationSource:_loc2_;
               _loc2_.userData.sprite.y = _loc3_.position.y * World.gameScale + _loc2_.spriteOffsetY;
               _loc2_.userData.sprite.x = _loc3_.position.x * World.gameScale + _loc2_.spriteOffsetX;
            }
            _loc1_++;
         }
      }
      
      public static function drawEdges() : void
      {
         var _loc2_:Rectangle = null;
         var _loc3_:Matrix = null;
         var _loc4_:Rectangle = null;
         var _loc5_:Rectangle = null;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc1_:int = 500 / Camera.camScale;
         World.currentLevel.allowWrapping && true;
         if(gameClip != null && transferClip != null && (Camera.followX > GroundUtils.sectionWidth * 6 - Camera.scaledWidth || Camera.followX < GroundUtils.sectionWidth + Camera.scaledWidth))
         {
            transferClip.visible = true;
            _loc4_ = gameClip.scrollRect;
            _loc5_ = transferClip.scrollRect;
            _loc6_ = gameClip.scaleX;
            gameClip.scrollRect = null;
            transferClip.scrollRect = null;
            gameClip.scaleX = 1;
            gameClip.scaleY = 1;
            transferClip.scaleX = 1;
            transferClip.scaleY = 1;
            _loc7_ = Camera.followY;
            _loc8_ = 0;
            if(GroundUtils.currentSection <= 1)
            {
               transferClip.fillRect(new Rectangle(GroundUtils.sectionWidth - _loc1_,_loc7_,_loc1_,Camera.scaledHeight),4469538);
               _loc3_ = new Matrix();
               _loc3_.translate(-GroundUtils.sectionWidth * 5,_loc8_);
               _loc2_ = new Rectangle(GroundUtils.sectionWidth - _loc1_,_loc7_,_loc1_,Camera.scaledHeight);
               transferClip.draw(gameClip,_loc3_,null,null,_loc2_);
            }
            if(GroundUtils.currentSection >= 5)
            {
               transferClip.fillRect(new Rectangle(GroundUtils.sectionWidth * 6,_loc7_,_loc1_,Camera.scaledHeight),4469538);
               _loc3_ = new Matrix();
               _loc3_.translate(GroundUtils.sectionWidth * 5,_loc8_);
               _loc2_ = new Rectangle(GroundUtils.sectionWidth * 6,_loc7_,_loc1_,Camera.scaledHeight);
               transferClip.draw(gameClip,_loc3_,null,null,_loc2_);
            }
            gameClip.scrollRect = _loc4_;
            transferClip.scrollRect = _loc5_;
            gameClip.scaleX = _loc6_;
            gameClip.scaleY = _loc6_;
            transferClip.scaleX = _loc6_;
            transferClip.scaleY = _loc6_;
         }
         else if(transferClip != null && !World.currentLevel.transferClip)
         {
            transferClip.visible = false;
         }
      }
      
      public static function addDebugger() : void
      {
         if(debugMode == null)
         {
            if(debugMode != null)
            {
               if(gameClip != null && gameClip.contains(debugMode.display))
               {
                  gameClip.removeChild(debugMode.display);
               }
            }
            if(World.drawDebugShapes)
            {
               debugMode = new BitmapDebug(GroundUtils.sectionWidth,GroundUtils.sectionHeight,3355443,true);
               debugMode.drawCollisionArbiters = true;
               debugMode.drawConstraints = true;
               debugMode.drawConstraintSprings = true;
               gameClip.addChild(debugMode.display);
            }
         }
      }
      
      public static function rc(param1:Sprite, param2:Sprite, param3:Boolean = false) : Sprite
      {
         var _loc4_:DisplayObjectContainer = null;
         if(param1 != null && param2 != null)
         {
            _loc4_ = param1.parent;
            if(_loc4_ != null && _loc4_.contains(param1))
            {
               _loc4_.removeChild(param1);
            }
            if(param2.parent != null)
            {
               param2.parent.removeChild(param2);
            }
            param2.x = param1.x;
            param2.y = param1.y;
            _loc4_.addChild(param2);
            param1 = param2;
         }
         else
         {
            param2 = new Sprite();
         }
         if(param3)
         {
            safeGlow(param2);
         }
         return param2;
      }
      
      public static function safeGlow(param1:Sprite) : *
      {
         var _loc3_:DisplayObjectContainer = null;
         var _loc2_:Sprite = new Sprite();
         if(param1.parent != null)
         {
            _loc3_ = param1.parent;
            param1.parent.removeChild(param1);
         }
         _loc2_.addChild(param1);
         addGlow(_loc2_);
         _loc3_.addChild(_loc2_);
      }
      
      public static function getIndex(param1:Sprite) : int
      {
         if(param1 != null && gameClip != null && gameClip.contains(param1))
         {
            return gameClip.getChildIndex(param1);
         }
         return 0;
      }
      
      public static function setBelow(param1:Sprite, param2:Sprite) : *
      {
         if(param1 != null && param2 != null && gameClip != null && gameClip.contains(param1) && gameClip.contains(param2))
         {
            gameClip.setChildIndex(param1,getIndex(param2) - 1);
         }
      }
      
      public static function addGlow(param1:Sprite, param2:Boolean = true, param3:Boolean = false, param4:Number = 1, param5:Number = 1) : *
      {
         if(param1 != null)
         {
            param1.filters = [new GlowFilter(10220752,1,param4 * (!!param2?80:4),param5 * (!!param3?80:4),2)];
         }
      }
   }
}
