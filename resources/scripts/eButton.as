package
{
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class eButton extends Sprite
   {
       
      
      protected var wideWidth:int = 110;
      
      protected var normalWidth:int = 90;
      
      protected var targetWidth:int = 50;
      
      protected var currentWidth:Number = 0;
      
      protected var normalHeight:int = 40;
      
      protected var wideHeight:int = 50;
      
      protected var targetHeight:int = 50;
      
      protected var currentHeight:Number = 0;
      
      protected var sbutton:SimpleButton;
      
      protected var myParent:Object;
      
      public var text:String;
      
      public var command:String;
      
      public var cLabel1:customFont;
      
      public var cLabel2:customFont;
      
      public var cLabel3:customFont;
      
      protected var imgButtonUp:Sprite;
      
      protected var imgButtonOver:Sprite;
      
      protected var imgButtonDown:Sprite;
      
      public var BUp:Sprite;
      
      public var BOver:Sprite;
      
      public var BDown:Sprite;
      
      public var targetX:Number = 0;
      
      public var targetY:Number = 0;
      
      public var currentX:Number = 0;
      
      public var currentY:Number = 0;
      
      public var offscreenX:Number = 0;
      
      public var offscreenY:Number = 0;
      
      public var enabled:Boolean = true;
      
      public var tw:int = 0;
      
      public var disableMe:Boolean = false;
      
      public var fixedSize:Boolean = false;
      
      private var animationFrame:int = -1;
      
      private var animationToggled:Boolean = false;
      
      public function eButton(param1:int, param2:int, param3:String, param4:Object, param5:String = "", param6:uint = 16776960, param7:int = 34)
      {
         this.imgButtonUp = new Sprite();
         this.imgButtonOver = new Sprite();
         this.imgButtonDown = new Sprite();
         this.BUp = new Sprite();
         this.BOver = new Sprite();
         this.BDown = new Sprite();
         super();
         this.text = param3;
         this.command = param5;
         x = param1;
         y = param2;
         var _loc8_:* = param3.indexOf("\n") > -1;
         _loc8_ = true;
         this.cLabel1 = new customFont(param7,param3,_loc8_,param6,3355443,false,0,true);
         this.cLabel2 = new customFont(param7,param3,_loc8_,param6,3355443,false,0,true);
         this.cLabel3 = new customFont(param7,param3,_loc8_,param6,3355443,false,0,true);
         if(!_loc8_)
         {
            this.cLabel1.x = 0 - this.cLabel1.width / 2;
            this.cLabel1.y = 0 - this.cLabel1.height / 2;
         }
         else
         {
            this.cLabel1.x = 0;
            this.cLabel1.y = 0;
         }
         this.cLabel2.x = this.cLabel1.x;
         this.cLabel2.y = this.cLabel1.y;
         this.cLabel3.x = this.cLabel2.x;
         this.cLabel3.y = this.cLabel2.y;
         this.fixedSize = false;
         if(!this.fixedSize)
         {
            this.tw = this.cLabel1.width;
            this.normalWidth = this.tw + 4;
            this.wideWidth = this.tw + 6;
            this.targetWidth = this.normalWidth;
            this.tw = this.cLabel1.height;
            this.normalHeight = this.tw + 4;
            this.wideHeight = this.tw + 6;
            this.targetHeight = this.normalHeight;
            if(this.normalWidth > this.normalHeight)
            {
               this.normalHeight = this.normalWidth;
               this.wideHeight = this.wideWidth;
               this.targetHeight = this.targetWidth;
            }
            if(this.normalHeight > this.normalWidth)
            {
               this.normalWidth = this.normalHeight;
               this.wideWidth = this.wideHeight;
               this.targetWidth = this.targetHeight;
            }
         }
         else
         {
            this.tw = 196;
            this.normalWidth = this.tw + 20;
            this.wideWidth = this.tw + 24;
            this.targetWidth = this.normalWidth;
            this.tw = this.cLabel1.height;
            this.normalHeight = this.tw + 12;
            this.wideHeight = this.tw + 14;
            this.targetHeight = this.normalHeight;
         }
         this.imgButtonUp.width = this.normalWidth;
         this.imgButtonOver.width = this.normalWidth;
         this.imgButtonDown.width = this.normalWidth;
         this.imgButtonUp.height = this.normalHeight;
         this.imgButtonOver.height = this.normalHeight;
         this.imgButtonDown.height = this.normalHeight;
         this.BUp.addChild(this.imgButtonUp);
         this.BUp.addChild(this.cLabel1);
         if(param5.indexOf("btn_pmg") > -1)
         {
            this.BUp.addChild(this.getGlyph());
         }
         this.BOver.addChild(this.imgButtonOver);
         this.BOver.addChild(this.cLabel2);
         if(param5.indexOf("btn_pmg") > -1)
         {
            this.BUp.addChild(this.getGlyph());
         }
         this.BDown.addChild(this.imgButtonDown);
         this.BDown.addChild(this.cLabel3);
         if(param5.indexOf("btn_pmg") > -1)
         {
            this.BUp.addChild(this.getGlyph());
         }
         if(this.command != "static")
         {
            this.sbutton = new SimpleButton(this.BUp,this.BOver,this.BDown,this.BUp);
            this.sbutton.useHandCursor = true;
            addEventListener(MouseEvent.CLICK,this.mouseClicked);
            addEventListener(MouseEvent.MOUSE_OVER,this.mouseOver);
            addEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
            addEventListener(Event.ENTER_FRAME,this.frame);
         }
         else
         {
            this.sbutton = new SimpleButton(this.BOver,this.BOver,this.BOver,this.BUp);
         }
         this.sbutton.x = 0;
         this.sbutton.y = 0;
         addChild(this.sbutton);
         this.myParent = param4;
      }
      
      public function getGlyph() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.y = this.cLabel1.y + 9;
         _loc1_.x = this.cLabel1.x + 2;
         return _loc1_;
      }
      
      public function raddChild(param1:Sprite, param2:Sprite) : void
      {
         this.BUp.addChild(param1);
         this.BOver.addChild(param2);
      }
      
      public function frame(param1:Event) : void
      {
         if(visible && !this.disableMe)
         {
            if(this.animationFrame > -1)
            {
               if(this.animationFrame % 2 == 0)
               {
                  this.toggleAnimation();
               }
               if(this.animationFrame > 8)
               {
                  this.animationFrame = -2;
               }
               this.animationFrame++;
            }
            this.cLabel1.visible = this.enabled;
         }
      }
      
      public function toggleAnimation() : void
      {
         if(!this.animationToggled)
         {
            this.BDown.removeChild(this.imgButtonDown);
            this.BOver.removeChild(this.imgButtonOver);
            this.BDown.addChild(this.imgButtonOver);
            this.BDown.setChildIndex(this.imgButtonOver,0);
            this.BOver.addChild(this.imgButtonDown);
            this.BOver.setChildIndex(this.imgButtonDown,0);
         }
         else
         {
            this.BDown.removeChild(this.imgButtonOver);
            this.BOver.removeChild(this.imgButtonDown);
            this.BDown.addChild(this.imgButtonDown);
            this.BDown.setChildIndex(this.imgButtonDown,0);
            this.BOver.addChild(this.imgButtonOver);
            this.BOver.setChildIndex(this.imgButtonOver,0);
         }
         this.animationToggled = !this.animationToggled;
      }
      
      public function mouseClicked(param1:MouseEvent) : void
      {
         this.performClick();
         SoundHandler.playSoundClass(sound_buttonPressed);
         this.animationFrame = 0;
      }
      
      public function performClick() : void
      {
         this.myParent.buttonPressed(this.command != ""?this.command:this.text);
      }
      
      public function mouseOver(param1:MouseEvent) : void
      {
      }
      
      public function mouseOut(param1:MouseEvent) : void
      {
         this.filters = [];
      }
   }
}
