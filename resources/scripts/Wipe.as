package
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Wipe extends MovieClip
   {
       
      
      var xSizes:Array;
      
      var ySizes:Array;
      
      var speeds:Array;
      
      public var tileWidth:Number;
      
      public var tileHeight:Number;
      
      public var numTiles:int = 0;
      
      public var rows:int = 1;
      
      public var columns:int = 1;
      
      public var target:DisplayObjectContainer;
      
      public var originalBitmap:Bitmap;
      
      public var outBitmap:Bitmap;
      
      public var running:Boolean = false;
      
      public var direction_in:Boolean = true;
      
      public var frameCount:int = 0;
      
      public var showLoading:Boolean = true;
      
      public function Wipe(param1:DisplayObjectContainer)
      {
         super();
         this.target = param1;
      }
      
      public function clearArrays() : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         this.xSizes = new Array();
         this.ySizes = new Array();
         this.rows = 20;
         this.columns = 20;
         this.tileWidth = global.gameWidth / this.columns;
         this.tileHeight = global.gameHeight / this.rows;
         this.numTiles = this.rows * this.columns;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.numTiles)
         {
            _loc2_ = _loc1_ / this.rows;
            _loc3_ = _loc1_ % this.columns;
            _loc4_ = this.xd(_loc2_);
            _loc5_ = this.xd(_loc3_) * 1.5;
            _loc6_ = -1 * (_loc5_ + _loc4_) * 8;
            this.ySizes.push(_loc6_);
            this.xSizes.push(_loc6_);
            _loc1_++;
         }
      }
      
      public function xd(param1:Number) : Number
      {
         return Math.abs(10 - param1);
      }
      
      public function beginWipe(param1:Boolean = true) : *
      {
         this.showLoading = param1;
         this.clearArrays();
         this.frameCount = 0;
         if(UIHandler.self.contains(this))
         {
            UIHandler.self.removeChild(this);
         }
         if(this.originalBitmap != null && this.contains(this.originalBitmap))
         {
            removeChild(this.originalBitmap);
         }
         this.copyScreen();
         addChild(this.outBitmap);
         UIHandler.self.addChild(this);
         addEventListener(Event.ENTER_FRAME,this.eFrame);
         this.running = true;
      }
      
      public function finishWipe() : void
      {
         this.running = true;
         this.direction_in = false;
      }
      
      public function eFrame(param1:Event) : *
      {
         if(this.running)
         {
            this.copySections();
            if(this.direction_in && this.xSizes[0] >= this.tileWidth && this.ySizes[0] >= this.tileHeight)
            {
               this.running = false;
               WipeHandler.wipeWaiting(this);
               if(WipeHandler.activeSwipe != this)
               {
                  this.endWipe();
               }
            }
            if(!this.direction_in && this.xSizes[210] <= 1 && this.ySizes[210] <= 1)
            {
               this.running = false;
               this.endWipe();
            }
         }
      }
      
      public function endWipe() : *
      {
         this.running = false;
         if(this.outBitmap != null && contains(this.outBitmap))
         {
            removeChild(this.outBitmap);
         }
         if(UIHandler.self.contains(this))
         {
            UIHandler.self.removeChild(this);
         }
         WipeHandler.wipeFinished(this);
      }
      
      public function copySections() : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc1_:int = 0;
         this.outBitmap.bitmapData.fillRect(new Rectangle(0,0,global.gameWidth,global.gameHeight),0);
         this.frameCount = this.frameCount + 5;
         if(this.frameCount > 100)
         {
            this.frameCount = 100;
         }
         _loc1_ = 0;
         while(_loc1_ < this.numTiles)
         {
            _loc2_ = _loc1_ / this.rows;
            _loc3_ = _loc1_ % this.columns;
            _loc4_ = (!!this.direction_in?6:-8) * 1;
            this.xSizes[_loc1_] = this.xSizes[_loc1_] + _loc4_;
            this.ySizes[_loc1_] = this.ySizes[_loc1_] + _loc4_;
            this.drawRect(_loc3_,_loc2_,this.limit(this.xSizes[_loc1_],1,this.tileWidth),this.limit(this.ySizes[_loc1_],1,this.tileHeight));
            _loc1_++;
         }
      }
      
      public function limit(param1:Number, param2:Number, param3:Number) : Number
      {
         return param1 < param2?Number(param2):param1 > param3?Number(param3):Number(param1);
      }
      
      public function drawRect(param1:Number, param2:Number, param3:*, param4:*) : *
      {
         var _loc5_:Rectangle = new Rectangle(param1 * this.tileWidth + this.tileWidth / 2 - param3 / 2,param2 * this.tileHeight + this.tileHeight / 2 - param4 / 2,param3,param4);
         this.outBitmap.bitmapData.copyPixels(this.originalBitmap.bitmapData,_loc5_,new Point(param1 * this.tileWidth + this.tileWidth / 2 - param3 / 2,param2 * this.tileHeight + this.tileHeight / 2 - param4 / 2));
      }
      
      public function copyScreen() : *
      {
         var _loc1_:Sprite = null;
         if(this.showLoading)
         {
            _loc1_ = new Sprite();
            _loc1_.x = global.gameWidth * 0.98 - _loc1_.width / 2;
            _loc1_.y = global.gameHeight * 0.98 - _loc1_.height / 2;
            this.target.addChild(_loc1_);
         }
         this.originalBitmap = new Bitmap(new BitmapData(640,480,false,0),PixelSnapping.NEVER,false);
         this.originalBitmap.bitmapData.draw(this.target,new Matrix(1,0,0,1,0,0),null);
         this.outBitmap = new Bitmap(new BitmapData(640,480,true,0),PixelSnapping.NEVER,false);
      }
   }
}
