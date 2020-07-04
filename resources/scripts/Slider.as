package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class Slider extends Sprite
   {
       
      
      protected var BUTTONWIDTH:int = 140;
      
      protected var BUTTONHEIGHT:int = 40;
      
      protected var sbutton:SimpleButton;
      
      protected var sClip:MovieClip;
      
      protected var parentClass;
      
      protected var handler:SliderHandler;
      
      protected var text:String;
      
      protected var cLabel1:customFont;
      
      protected var targetWidth;
      
      protected var normalWidth;
      
      protected var currentWidth;
      
      protected var currentText:String;
      
      protected var transCurrent;
      
      protected var transTarget;
      
      protected var transLow;
      
      protected var transHigh;
      
      protected var targetX;
      
      public var inactive = true;
      
      public var secondSlide = false;
      
      public function Slider(param1:int, param2:int, param3:String, param4:*, param5:*)
      {
         super();
         this.handler = param5;
         this.parentClass = param4;
         this.cLabel1 = new customFont(28,param3,false,0,16777215,false,0);
         this.y = param2;
         this.x = 800 + param1;
         this.targetX = 240;
         this.cLabel1.x = 0 - this.cLabel1.width / 2;
         this.cLabel1.y = 5;
         addChild(this.cLabel1);
         addEventListener(Event.ENTER_FRAME,this.frame);
         this.text = param3;
      }
      
      public function slide() : void
      {
         this.targetX = 240;
         this.inactive = false;
         this.secondSlide = false;
      }
      
      public function finish() : void
      {
         visible = false;
         this.inactive = true;
         SliderHandler.notifyEnd(this);
      }
      
      public function frame(param1:Event) : *
      {
         if(!this.inactive)
         {
            this.parentClass.setChildIndex(this,this.parentClass.numChildren - 1);
            this.x = this.x + (this.targetX - x) / 10;
            if(Math.abs(this.targetX - x) < 10)
            {
               if(!this.secondSlide)
               {
                  this.secondSlide = true;
                  this.targetX = -300;
               }
               else
               {
                  this.finish();
               }
            }
         }
      }
   }
}
