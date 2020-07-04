package
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class iButton extends Sprite
   {
       
      
      protected var sbutton:SimpleButton;
      
      protected var myParent;
      
      public var text:String;
      
      protected var label1:TextField;
      
      protected var label2:TextField;
      
      protected var label3:TextField;
      
      protected var format:TextFormat;
      
      protected var cLabel1:customFont;
      
      protected var cLabel2:customFont;
      
      protected var cLabel3:customFont;
      
      protected var imgIconUp:MovieClip;
      
      protected var imgIconDown:MovieClip;
      
      protected var imgBackgroundUp:MovieClip;
      
      protected var imgBackgroundDown:MovieClip;
      
      protected var currentText:String;
      
      public var transCurrent:Number;
      
      public var transTarget:Number;
      
      public var transLow:Number;
      
      public var transHigh:Number;
      
      public var wideWidth:int = 110;
      
      public var normalWidth:int = 90;
      
      public var targetWidth:int;
      
      public var currentWidth:Number;
      
      public var normalHeight:int = 40;
      
      public var wideHeight:int = 50;
      
      public var targetHeight:int = 0;
      
      public var currentHeight:Number = 0;
      
      public var gf:GlowFilter;
      
      public var disableFilters:Boolean;
      
      public var filterOverVal:int = 16777215;
      
      public var filterOutVal:int = 0;
      
      public var tw:int = 0;
      
      public var BUp:Sprite;
      
      public var BDown:Sprite;
      
      public var eventListeners:Array;
      
      public var outFilter:GlowFilter;
      
      public var overFilter:GlowFilter;
      
      public var mouseIsOver:Boolean = false;
      
      public var toggleable:Boolean = false;
      
      public var toggleState:Boolean = false;
      
      private var animationCounter:int = -1;
      
      private var animationToggled:Boolean = false;
      
      public function iButton(param1:String, param2:Object, param3:Class, param4:int = 0, param5:int = 0, param6:Class = null, param7:Boolean = false)
      {
         var _loc8_:Sprite = null;
         var _loc9_:Sprite = null;
         this.BUp = new Sprite();
         this.BDown = new Sprite();
         this.eventListeners = new Array();
         super();
         x = param4;
         y = param5;
         this.toggleable = param7;
         this.disableFilters = true;
         this.transCurrent = 1;
         this.transTarget = 1;
         this.transHigh = 2;
         this.transLow = 1;
         if(param6 == null)
         {
            this.imgIconUp = new param3();
            this.imgIconDown = new param3();
         }
         else
         {
            this.imgIconUp = new param6();
            _loc8_ = new param3();
            _loc8_.y = -32;
            this.imgIconUp.addChild(_loc8_);
            this.imgIconDown = new param6();
            _loc9_ = new param3();
            _loc9_.y = -32;
            this.imgIconDown.addChild(_loc9_);
         }
         this.BUp.addChild(this.imgIconUp);
         this.BDown.addChild(this.imgIconDown);
         this.sbutton = new SimpleButton(this.BUp,this.BUp,this.BDown,this.BUp);
         this.sbutton.x = 0;
         this.sbutton.y = 0;
         this.sbutton.useHandCursor = true;
         this.addEventListener(MouseEvent.CLICK,this.mouseClicked);
         this.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
         addChild(this.sbutton);
         this.tw = this.sbutton.width;
         this.normalWidth = this.tw;
         this.wideWidth = this.tw + 15;
         this.targetWidth = this.normalWidth;
         this.tw = this.sbutton.height;
         this.normalHeight = this.tw;
         this.wideHeight = this.tw * (this.wideWidth / this.normalWidth);
         this.targetHeight = this.normalHeight;
         this.text = param1;
         this.myParent = param2;
         this.outFilter = new GlowFilter(this.filterOutVal,1,2,2,5,1,false,false);
         this.overFilter = this.returnOverFilter();
         if(!this.disableFilters)
         {
            this.sbutton.filters = [this.returnOutFilter()];
         }
      }
      
      public function flash() : void
      {
         this.transCurrent = this.transHigh;
         this.transTarget = this.transLow;
      }
      
      public function setTile(param1:int, param2:int) : *
      {
         this.imgIconUp.scrollRect = new Rectangle(param1 * 16,param2 * 16,16,16);
         this.imgIconDown.scrollRect = new Rectangle(param1 * 16,param2 * 16,16,16);
         this.normalWidth = 16;
         this.normalHeight = 16;
         this.wideWidth = 26;
         this.wideHeight = 26;
      }
      
      public function toggleAnimation() : void
      {
         if(!this.animationToggled)
         {
            this.targetWidth = this.normalWidth;
            this.targetHeight = this.normalHeight;
         }
         else
         {
            this.targetWidth = this.wideWidth;
            this.targetHeight = this.wideWidth;
         }
         this.animationToggled = !this.animationToggled;
      }
      
      public function frame(param1:Event) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         if(this.animationCounter > -1)
         {
            this.animationCounter--;
            if(this.animationCounter % 2 == 0)
            {
               this.toggleAnimation();
            }
            if(this.animationCounter == -1)
            {
               this.addEventListener(Event.ENTER_FRAME,this.frame);
               this.targetWidth = this.normalWidth;
               this.targetHeight = this.normalHeight;
            }
         }
         if(visible)
         {
            _loc2_ = false;
            this.currentWidth = this.BUp.width;
            this.currentWidth = this.currentWidth + (this.targetWidth - this.currentWidth) / 6;
            this.currentWidth = this.targetWidth;
            if(Math.abs(this.currentWidth - this.targetWidth) < 1)
            {
               _loc2_ = true;
            }
            this.BUp.width = this.currentWidth;
            this.BDown.width = this.currentWidth;
            _loc3_ = false;
            this.currentHeight = this.BUp.height;
            this.currentHeight = this.currentHeight + (this.targetHeight - this.currentHeight) / 6;
            this.currentHeight = this.targetHeight;
            if(Math.abs(this.currentHeight - this.targetHeight) < 1)
            {
               _loc3_ = true;
            }
            this.BUp.height = this.currentHeight;
            this.BDown.height = this.currentHeight;
            if(_loc2_ && _loc3_ && this.animationCounter == -1)
            {
               removeEventListener(Event.ENTER_FRAME,this.frame);
            }
         }
      }
      
      public function addGlyph(param1:DisplayObject, param2:DisplayObject) : void
      {
         addChild(param1);
      }
      
      public function mouseClicked(param1:MouseEvent) : void
      {
         if(this.toggleable)
         {
            this.clicked_toggle();
         }
         else
         {
            this.performClick();
            this.clicked_animate();
         }
      }
      
      public function clicked_animate() : void
      {
         this.animationCounter = 8;
         removeEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
         removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOver);
         this.addEventListener(Event.ENTER_FRAME,this.frame);
         SoundHandler.playSoundClass(sound_buttonPressed);
      }
      
      public function clicked_toggle() : void
      {
         this.toggleState = !this.toggleState;
         var _loc1_:int = !!this.toggleState?2:1;
         this.imgIconUp.gotoAndStop(_loc1_);
         this.imgIconDown.gotoAndStop(_loc1_);
         this.performClick();
      }
      
      public function performClick() : void
      {
         this.myParent.buttonPressed(this.text);
      }
      
      public function returnOverFilter() : GlowFilter
      {
         return new GlowFilter(this.filterOverVal,1,4,4,5,1,false,false);
      }
      
      public function returnOutFilter() : GlowFilter
      {
         return new GlowFilter(14607170,1,14,14,1,1);
      }
      
      public function mouseOver(param1:MouseEvent) : void
      {
         this.mouseIsOver = true;
         this.transTarget = this.transHigh;
         if(!this.disableFilters)
         {
            this.sbutton.filters = [this.returnOverFilter()];
         }
         this.targetWidth = this.wideWidth;
         this.targetHeight = this.wideHeight;
         this.addEventListener(Event.ENTER_FRAME,this.frame);
         try
         {
            if(this.myParent != null && this.myParent.contains(this))
            {
               this.myParent.setChildIndex(this,this.myParent.numChildren - 1);
            }
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      public function mouseOut(param1:MouseEvent) : void
      {
         this.mouseIsOver = false;
         this.transTarget = this.transLow;
         if(!this.disableFilters)
         {
            this.sbutton.filters = [this.returnOutFilter()];
         }
         this.targetWidth = this.normalWidth;
         this.targetHeight = this.normalHeight;
         this.addEventListener(Event.ENTER_FRAME,this.frame);
      }
      
      public function cleanUp() : void
      {
         this.clearEventListeners();
         this.myParent = null;
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
   }
}
