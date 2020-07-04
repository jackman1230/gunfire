package
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class CustomWindow extends Sprite
   {
       
      
      public var userWidth:Number = 404;
      
      public var userHeight:Number = 404;
      
      public var originalUserWidth:Number = 0;
      
      public var originalUserHeight:Number = 0;
      
      public var leftWidth:int = 17;
      
      public var rightWidth:int = 17;
      
      public var topHeight:int = 17;
      
      public var bottomHeight:int = 17;
      
      public var middlewidth:int = 0;
      
      public var middleHeight:int = 0;
      
      public var bgBitmap:Bitmap;
      
      public var bgBitmapData:BitmapData;
      
      public var referenceBitmapData:BitmapData;
      
      public var tempBitmapData:BitmapData;
      
      public var reference:Sprite;
      
      public var referenceWidth:int = 200;
      
      public var referenceHeight:int = 200;
      
      public var titleFont:customFont;
      
      public var titleString:String = "";
      
      public var closeButton:MovieClip;
      
      public var hasCloseButton:Boolean = false;
      
      public var buttonSpace:int = 14;
      
      public var buttonTop:int = 12;
      
      public var destroying:Boolean = false;
      
      private var eventListeners:Array;
      
      public var backgroundDrawn:Boolean;
      
      public var loadingSprite:Sprite;
      
      public var hasBorders:Boolean = true;
      
      public var drawBackground:Boolean = true;
      
      public var gMode:GameMode;
      
      public var myWidgetSlider:WidgetSlider;
      
      public var sizeX:Number = 0;
      
      public var sizeY:Number = 0;
      
      public function CustomWindow(param1:int = 0, param2:int = 0, param3:int = 640, param4:int = 448, param5:String = " ", param6:Boolean = true, param7:Boolean = true, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false)
      {
         this.reference = new newWindowBG();
         this.eventListeners = new Array();
         super();
         this.drawBackground = param6;
         this.gMode = GameMode.gameMode;
         this.x = param1;
         this.y = param2;
         this.userWidth = param3;
         this.userHeight = param4;
         this.originalUserWidth = this.userWidth;
         this.originalUserHeight = this.userHeight;
         this.hasCloseButton = param8;
         if(this.drawBackground)
         {
            this.drawBackgroundImage(this.hasBorders);
         }
         if(param7)
         {
            this.addDragBar();
         }
         if(this.hasCloseButton)
         {
            this.addCloseButton();
         }
         if(param5 != "")
         {
            this.addTitle(param5);
         }
         if(param10)
         {
            this.addEventListener(Event.REMOVED_FROM_STAGE,this.cleanUp);
         }
      }
      
      public function getCenter() : Point
      {
         if(this.backgroundDrawn)
         {
            return new Point(this.middlewidth / 2 + this.leftWidth,this.middleHeight / 2 + this.topHeight);
         }
         return new Point(this.middlewidth / 2 + 2,this.topHeight / 2 + 2);
      }
      
      public function addWidgetSlider() : void
      {
         this.myWidgetSlider = new WidgetSlider(this);
      }
      
      public function rc(param1:Sprite, param2:Sprite, param3:Boolean = false, param4:Boolean = false) : Sprite
      {
         if(param4 == true)
         {
            if(this.myWidgetSlider == null)
            {
            }
            if(this.myWidgetSlider == null)
            {
               this.addWidgetSlider();
            }
            return this.myWidgetSlider.addWidget(SpriteUtils.rc(param1,param2,param3));
         }
         return SpriteUtils.rc(param1,param2,param3);
      }
      
      public function makeButton(param1:Sprite, param2:String) : *
      {
         if(this.myWidgetSlider == null)
         {
         }
         if(this.myWidgetSlider == null)
         {
            this.addWidgetSlider();
         }
         this.myWidgetSlider.addWidget(MakeButton.make(param1,param2).overrideParent(this));
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         super.addEventListener(param1,param2,param3,param4,param5);
         var _loc6_:Object = new Object();
         _loc6_.type = param1;
         _loc6_.listener = param2;
         _loc6_.useCapture = param3;
         this.eventListeners.push(_loc6_);
      }
      
      public function clearEventListeners() : void
      {
         var _loc1_:Object = null;
         for each(_loc1_ in this.eventListeners)
         {
            removeEventListener(_loc1_.type,_loc1_.listener,_loc1_.useCapture);
         }
      }
      
      public function buttonPressed(param1:String) : void
      {
         switch(param1)
         {
            case "custom_close":
               this.cleanUp();
         }
         GameMode.gameMode.buttonPressed(param1);
      }
      
      public function cleanUp(param1:Event = null) : void
      {
         if(!this.destroying)
         {
            this.destroying = true;
            this.clearEventListeners();
            this.clearChildren();
         }
      }
      
      public function clearChildren() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:int = numChildren - 1;
         while(_loc2_ > -1)
         {
            _loc1_ = getChildAt(_loc2_);
            if(_loc1_ != null && contains(_loc1_))
            {
               removeChild(_loc1_);
               if(_loc1_ is iButton)
               {
                  (_loc1_ as iButton).cleanUp();
               }
               if(_loc1_ is CustomWindow)
               {
                  (_loc1_ as CustomWindow).cleanUp();
               }
            }
            _loc2_--;
         }
         x = null;
      }
      
      public function addCloseButton() : void
      {
         this.closeButton = new closebutton_horz();
         this.closeButton.mouseChildren = false;
         this.closeButton.buttonMode = true;
         this.closeButton.useHandCursor = true;
         this.closeButton.addEventListener(MouseEvent.CLICK,this.closeWindow);
         addChild(this.closeButton);
         this.closeButton.x = this.userWidth - this.buttonSpace - 5;
         this.closeButton.y = this.buttonTop + 2;
      }
      
      public function closeWindow(param1:MouseEvent) : void
      {
         this.cleanUp();
      }
      
      public function addTitle(param1:String) : void
      {
         if(this.titleFont == null)
         {
            this.titleFont = new customFont(30," ",false);
            addChild(this.titleFont);
         }
         this.titleFont.drawString(param1);
         this.titleFont.y = 0 - this.userHeight / 2 + this.buttonTop - this.titleFont.height / 2 + 12;
         this.titleFont.x = 0 - this.userWidth / 2 + 40;
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         this.userWidth = param1;
         this.userHeight = param2;
         if(this.drawBackground)
         {
            this.drawBackgroundImage(this.hasBorders);
         }
      }
      
      public function addDragBar() : void
      {
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.dragbarMouseDown);
         this.addEventListener(MouseEvent.MOUSE_UP,this.dragbarMouseUp);
      }
      
      public function removeDragBar() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_DOWN,this.dragbarMouseDown);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.dragbarMouseUp);
      }
      
      public function dragbarMouseDown(param1:MouseEvent = null) : void
      {
         var _loc2_:Rectangle = new Rectangle(0,0,0,0);
         _loc2_.top = this.y;
         _loc2_.left = this.x;
         _loc2_.right = this.width + _loc2_.left;
         _loc2_.bottom = this.topHeight + _loc2_.top;
         if(_loc2_.contains(param1.stageX,param1.stageY))
         {
            startDrag();
         }
      }
      
      public function dragbarMouseUp(param1:Event = null) : void
      {
         stopDrag();
      }
      
      public function drawBackgroundImage(param1:Boolean = false) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         this.hasBorders = param1;
         this.middlewidth = this.userWidth - this.leftWidth - this.rightWidth;
         this.middleHeight = this.userHeight - this.topHeight - this.bottomHeight;
         this.sizeX = !!(0 + (this.userWidth > this.referenceWidth))?Number(this.userWidth):Number(this.referenceWidth);
         this.sizeY = !!(0 + (this.userHeight > this.referenceHeight))?Number(this.userHeight):Number(this.referenceHeight);
         this.referenceBitmapData = new BitmapData(this.sizeX,this.sizeY,true,0);
         this.tempBitmapData = new BitmapData(this.sizeX,this.sizeY,true,0);
         this.bgBitmapData = new BitmapData(this.sizeX,this.sizeY,true,0);
         this.referenceBitmapData.draw(this.reference);
         _loc2_ = this.userWidth / (this.referenceWidth - this.leftWidth - this.rightWidth);
         _loc3_ = this.userHeight / (this.referenceHeight - this.topHeight - this.bottomHeight);
         var _loc4_:int = this.referenceWidth - this.rightWidth - this.leftWidth;
         var _loc5_:int = this.referenceHeight - this.topHeight - this.bottomHeight;
         if(this.hasBorders)
         {
            this.bgBitmapData.copyPixels(this.referenceBitmapData,new Rectangle(0,0,this.leftWidth,this.topHeight),new Point(0,0));
            this.bgBitmapData.copyPixels(this.referenceBitmapData,new Rectangle(this.referenceWidth - this.rightWidth,0,this.rightWidth,this.topHeight),new Point(this.userWidth - this.rightWidth,0));
            this.bgBitmapData.copyPixels(this.referenceBitmapData,new Rectangle(0,this.referenceHeight - this.bottomHeight,this.leftWidth,this.bottomHeight),new Point(0,this.userHeight - this.bottomHeight));
            this.bgBitmapData.copyPixels(this.referenceBitmapData,new Rectangle(this.referenceWidth - this.rightWidth,this.referenceHeight - this.bottomHeight,this.rightWidth,this.bottomHeight),new Point(this.userWidth - this.rightWidth,this.userHeight - this.bottomHeight));
            this.tempBitmapData.copyPixels(this.referenceBitmapData,new Rectangle(this.leftWidth,this.referenceHeight - this.bottomHeight,_loc4_,this.bottomHeight),new Point(0,this.userHeight - this.bottomHeight));
            this.bgBitmapData.draw(this.tempBitmapData,new Matrix(_loc2_,0,0,1),null,null,new Rectangle(this.leftWidth,this.userHeight - this.bottomHeight,this.middlewidth,this.bottomHeight));
            this.tempBitmapData.copyPixels(this.referenceBitmapData,new Rectangle(this.referenceWidth - this.rightWidth,this.topHeight,this.rightWidth,_loc5_),new Point(this.userWidth - this.rightWidth,0));
            this.bgBitmapData.draw(this.tempBitmapData,new Matrix(1,0,0,_loc3_),null,null,new Rectangle(this.userWidth - this.rightWidth,this.topHeight,this.rightWidth,this.middleHeight));
            this.tempBitmapData.copyPixels(this.referenceBitmapData,new Rectangle(0,this.topHeight,this.leftWidth,_loc5_),new Point(0,0));
            this.bgBitmapData.draw(this.tempBitmapData,new Matrix(1,0,0,_loc3_),null,null,new Rectangle(0,this.topHeight,this.leftWidth,this.middleHeight));
            this.tempBitmapData.copyPixels(this.referenceBitmapData,new Rectangle(this.leftWidth,0,_loc4_,this.topHeight),new Point(0,0));
            this.bgBitmapData.draw(this.tempBitmapData,new Matrix(_loc2_,0,0,1),null,null,new Rectangle(this.leftWidth,0,this.middlewidth,this.topHeight));
         }
         this.tempBitmapData = new BitmapData(this.sizeX,this.sizeY,true,0);
         this.tempBitmapData.copyPixels(this.referenceBitmapData,new Rectangle(this.leftWidth,this.topHeight,_loc4_,_loc5_),new Point(0,0));
         if(this.hasBorders)
         {
            this.bgBitmapData.draw(this.tempBitmapData,new Matrix(_loc2_,0,0,_loc3_),null,null,new Rectangle(this.leftWidth,this.topHeight,this.userWidth - this.rightWidth - this.leftWidth,this.userHeight - this.topHeight - this.bottomHeight));
         }
         else
         {
            this.bgBitmapData.draw(this.tempBitmapData,new Matrix(_loc2_,0,0,_loc3_),null,null,new Rectangle(0,0,this.userWidth,this.userHeight));
         }
         if(this.backgroundDrawn)
         {
            if(this.bgBitmap != null && contains(this.bgBitmap))
            {
               removeChild(this.bgBitmap);
               this.bgBitmap.bitmapData.dispose;
            }
         }
         this.backgroundDrawn = true;
         this.bgBitmap = new Bitmap(this.bgBitmapData,"auto",false);
         addChild(this.bgBitmap);
         setChildIndex(this.bgBitmap,0);
         this.bgBitmap.x = 0 - this.userWidth / 2;
         this.bgBitmap.y = 0 - this.userHeight / 2;
      }
   }
}
