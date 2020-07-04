package
{
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class WidgetSlider extends Sprite
   {
      
      public static const translationStart:Number = 200;
       
      
      public var myParent:CustomWindow;
      
      public var tweeners:Vector.<Tweenie>;
      
      public function WidgetSlider(param1:CustomWindow)
      {
         this.tweeners = new Vector.<Tweenie>();
         super();
         this.myParent = param1;
         this.addEventListener(Event.ENTER_FRAME,this.onFrame);
      }
      
      public function addWidget(param1:Sprite, param2:Boolean = false) : Sprite
      {
         if(!param2)
         {
            this.tweeners.push(new Tweenie().tweenSprite(-(translationStart + this.tweeners.length * 60),param1.y,param1,false,false,4 + this.tweeners.length / 8,false));
         }
         else
         {
            this.tweeners.push(new Thwomp().tweenSprite(-400,param1.y,param1,false,false,4 + this.tweeners.length / 8,false));
         }
         return param1;
      }
      
      public function onFrame(param1:Event = null) : void
      {
         var _loc2_:int = this.tweeners.length - 1;
         while(_loc2_ > -1)
         {
            if(this.tweeners[_loc2_] != null)
            {
               this.tweeners[_loc2_].onFrame(null);
               if(this.tweeners[_loc2_].finished)
               {
                  this.tweeners.pop();
               }
            }
            _loc2_--;
         }
      }
   }
}
