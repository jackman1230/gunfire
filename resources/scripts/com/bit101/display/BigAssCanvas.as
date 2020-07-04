package com.bit101.display
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.IBitmapDrawable;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BigAssCanvas extends Sprite
   {
       
      
      public var _bitmaps:Array;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _transparent:Boolean;
      
      private var _color:uint;
      
      public function BigAssCanvas(param1:Number, param2:Number, param3:Boolean = false, param4:uint = 16777215)
      {
         super();
         this._width = param1;
         this._height = param2;
         this._transparent = param3;
         this._color = param4;
         this.makeBitmaps();
      }
      
      public function makeBitmaps() : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Bitmap = null;
         this._bitmaps = new Array();
         var _loc1_:Number = this._height;
         var _loc2_:Number = 0;
         while(_loc1_ > 0)
         {
            _loc3_ = 0;
            _loc4_ = this._width;
            while(_loc4_ > 0)
            {
               _loc5_ = new Bitmap(new BitmapData(Math.min(2880,_loc4_),Math.min(2880,_loc1_),this._transparent,this._color));
               _loc5_.x = _loc3_;
               _loc5_.y = _loc2_;
               addChild(_loc5_);
               this._bitmaps.push(_loc5_);
               _loc4_ = _loc4_ - _loc5_.width;
               _loc3_ = _loc3_ + _loc5_.width;
            }
            _loc2_ = _loc2_ + Math.min(2880,_loc1_);
            _loc1_ = _loc1_ - Math.min(2880,_loc1_);
         }
      }
      
      public function draw(param1:IBitmapDrawable, param2:Matrix = null, param3:ColorTransform = null, param4:String = null, param5:Rectangle = null, param6:Boolean = false) : void
      {
         var _loc8_:Bitmap = null;
         var _loc9_:Matrix = null;
         var _loc10_:Rectangle = null;
         if(param2 == null)
         {
            param2 = new Matrix();
         }
         var _loc7_:int = 0;
         while(_loc7_ < this._bitmaps.length)
         {
            _loc8_ = this._bitmaps[_loc7_] as Bitmap;
            _loc9_ = param2.clone();
            _loc9_.tx = _loc9_.tx - _loc8_.x;
            _loc9_.ty = _loc9_.ty - _loc8_.y;
            if(param5 != null)
            {
               _loc10_ = param5.clone();
               _loc10_.x = _loc10_.x - _loc8_.x;
               _loc10_.y = _loc10_.y - _loc8_.y;
            }
            else
            {
               _loc10_ = null;
            }
            _loc8_.bitmapData.draw(param1,_loc9_,param3,param4,_loc10_,param6);
            _loc7_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:Bitmap = null;
         while(this._bitmaps.length > 0)
         {
            _loc1_ = this._bitmaps.shift() as Bitmap;
            removeChild(_loc1_);
            _loc1_.bitmapData.dispose();
         }
      }
      
      public function fillRect(param1:Rectangle, param2:uint) : void
      {
         var _loc4_:Bitmap = null;
         var _loc5_:Rectangle = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._bitmaps.length)
         {
            _loc4_ = this._bitmaps[_loc3_] as Bitmap;
            _loc5_ = param1.clone();
            _loc5_.x = _loc5_.x - _loc4_.x;
            _loc5_.y = _loc5_.y - _loc4_.y;
            _loc4_.bitmapData.fillRect(_loc5_,param2);
            _loc3_++;
         }
      }
      
      public function getPixel(param1:Number, param2:Number) : uint
      {
         var _loc4_:Bitmap = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._bitmaps.length)
         {
            _loc4_ = this._bitmaps[_loc3_] as Bitmap;
            if(param1 >= _loc4_.x && param1 < _loc4_.x + _loc4_.width && param2 >= _loc4_.y && param2 < _loc4_.y + _loc4_.height)
            {
               return _loc4_.bitmapData.getPixel(param1 - _loc4_.x,param2 - _loc4_.y);
            }
            _loc3_++;
         }
         return 0;
      }
      
      public function setPixel(param1:Number, param2:Number, param3:uint) : void
      {
         var _loc5_:Bitmap = null;
         var _loc4_:int = 0;
         while(_loc4_ < this._bitmaps.length)
         {
            _loc5_ = this._bitmaps[_loc4_] as Bitmap;
            if(param1 >= _loc5_.x && param1 < _loc5_.x + _loc5_.width && param2 >= _loc5_.y && param2 < _loc5_.y + _loc5_.height)
            {
               _loc5_.bitmapData.setPixel(Math.round(param1 - _loc5_.x),Math.round(param2 - _loc5_.y),param3);
            }
            _loc4_++;
         }
      }
      
      public function getPixel32(param1:Number, param2:Number) : uint
      {
         var _loc4_:Bitmap = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._bitmaps.length)
         {
            _loc4_ = this._bitmaps[_loc3_] as Bitmap;
            if(param1 >= _loc4_.x && param1 < _loc4_.x + _loc4_.width && param2 >= _loc4_.y && param2 < _loc4_.y + _loc4_.height)
            {
               return _loc4_.bitmapData.getPixel32(param1 - _loc4_.x,param2 - _loc4_.y);
            }
            _loc3_++;
         }
         return 0;
      }
      
      public function setPixel32(param1:Number, param2:Number, param3:uint) : void
      {
         var _loc5_:Bitmap = null;
         var _loc4_:int = 0;
         while(_loc4_ < this._bitmaps.length)
         {
            _loc5_ = this._bitmaps[_loc4_] as Bitmap;
            if(param1 >= _loc5_.x && param1 < _loc5_.x + _loc5_.width && param2 >= _loc5_.y && param2 < _loc5_.y + _loc5_.height)
            {
               _loc5_.bitmapData.setPixel32(param1 - _loc5_.x,param2 - _loc5_.y,param3);
            }
            _loc4_++;
         }
      }
      
      public function noise(param1:int, param2:uint = 0, param3:uint = 255, param4:uint = 7, param5:Boolean = false) : void
      {
         var _loc7_:Bitmap = null;
         var _loc6_:int = 0;
         while(_loc6_ < this._bitmaps.length)
         {
            _loc7_ = this._bitmaps[_loc6_] as Bitmap;
            _loc7_.bitmapData.noise(param1,param2,param3,param4,param5);
            _loc6_++;
         }
      }
      
      public function perlinNoise(param1:Number, param2:Number, param3:uint, param4:int, param5:Boolean, param6:uint = 7, param7:Boolean = false) : void
      {
         var _loc10_:Bitmap = null;
         var _loc11_:Array = null;
         var _loc12_:int = 0;
         var _loc8_:Array = new Array();
         var _loc9_:int = 0;
         while(_loc9_ < param3)
         {
            _loc8_.push(new Point());
            _loc9_++;
         }
         _loc9_ = 0;
         while(_loc9_ < this._bitmaps.length)
         {
            _loc10_ = this._bitmaps[_loc9_] as Bitmap;
            _loc11_ = new Array();
            _loc12_ = 0;
            while(_loc12_ < _loc8_.length)
            {
               _loc11_[_loc12_] = new Point(_loc8_[_loc12_].x + _loc10_.x,_loc8_[_loc12_].y + _loc10_.y);
               _loc12_++;
            }
            _loc10_.bitmapData.perlinNoise(param1,param2,param3,param4,false,param5,param6,param7,_loc11_);
            _loc9_++;
         }
      }
      
      public function lock() : void
      {
         var _loc2_:Bitmap = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._bitmaps.length)
         {
            _loc2_ = this._bitmaps[_loc1_] as Bitmap;
            _loc2_.bitmapData.lock();
            _loc1_++;
         }
      }
      
      public function unlock() : void
      {
         var _loc2_:Bitmap = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._bitmaps.length)
         {
            _loc2_ = this._bitmaps[_loc1_] as Bitmap;
            _loc2_.bitmapData.unlock();
            _loc1_++;
         }
      }
   }
}
