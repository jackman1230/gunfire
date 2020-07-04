package
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   
   public class Collection extends Sprite
   {
       
      
      protected var parentClass:UIHandler;
      
      public var myText:customFont;
      
      public var myValue:customFont;
      
      public var intValue:int;
      
      public var gf:GlowFilter;
      
      public var moveUp:Boolean = false;
      
      public var moveDelta:int = 12;
      
      public var handler:CollectionHandler;
      
      public const defaultSize:int = 21;
      
      public var targetY:Number = 100;
      
      public var frameCount:int = -1;
      
      public function Collection(param1:int, param2:int, param3:String, param4:int, param5:UIHandler, param6:CollectionHandler)
      {
         super();
         this.parentClass = param5;
         this.handler = param6;
         this.intValue = param4;
         var _loc7_:* = Math.random() * 128 << 16;
         var _loc8_:* = Math.random() * 128 << 8;
         var _loc9_:int = Math.random() * 128;
         var _loc10_:int = _loc7_ + _loc8_ + _loc9_ + 8421504;
         this.myValue = new customFont(this.defaultSize,"+" + param4.toString(),false,15658734,0);
         this.myValue.x = 0;
         this.myValue.y = 0;
         this.myText = new customFont(this.defaultSize,param3,false,_loc10_,0);
         this.myText.x = this.myValue.x + this.myValue.width + 7;
         this.myText.y = 0;
         this.x = param1;
         this.y = param2;
         addChild(this.myText);
         addChild(this.myValue);
         addEventListener(Event.ENTER_FRAME,this.frame);
         this.filters = [new GlowFilter(0,1,3,3,3.1,1,false,false)];
         this.parentClass.addChild(this);
      }
      
      public function destroyMe() : *
      {
         if(this.parentClass.contains(this))
         {
            this.parentClass.removeChild(this);
         }
         removeEventListener(Event.ENTER_FRAME,this.frame);
      }
      
      public function frame(param1:Event) : *
      {
         this.y = this.y + (this.targetY - this.y) / 4;
         if(Math.abs(this.y - this.targetY) < 1.4 && this.frameCount == -1)
         {
            this.frameCount = 0;
         }
         if(this.frameCount > -1)
         {
            this.frameCount++;
            if(this.frameCount > 40)
            {
               CollectionHandler.notifyDestruction(this);
               this.x = this.x - this.frameCount;
               if(this.x < -200)
               {
                  this.destroyMe();
               }
            }
         }
      }
   }
}
