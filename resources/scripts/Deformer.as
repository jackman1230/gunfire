package
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class Deformer extends MovieClip
   {
       
      
      public var myClip:Sprite;
      
      public var frameCount:Number = 0;
      
      public var listenersEnabled:Boolean = false;
      
      public var yVal:Number = 0;
      
      var flippity:int = 0;
      
      public function Deformer(param1:Sprite)
      {
         super();
         this.myClip = param1;
         addChild(this.myClip);
         this.enableListeners();
      }
      
      public function enableListeners() : void
      {
         if(!this.listenersEnabled)
         {
            addEventListener(Event.ENTER_FRAME,this.onFrame);
            addEventListener(Event.REMOVED_FROM_STAGE,this.byebye);
         }
         this.listenersEnabled = true;
      }
      
      public function disableListeners() : void
      {
         if(this.listenersEnabled)
         {
            removeEventListener(Event.ENTER_FRAME,this.onFrame);
            removeEventListener(Event.REMOVED_FROM_STAGE,this.byebye);
         }
         this.listenersEnabled = false;
      }
      
      public function onFrame(param1:Event = null) : void
      {
         this.flippity++;
         if(this.flippity % 1 == 0)
         {
            this.frameCount = this.frameCount + 0.1;
            this.myClip.scaleX = 1 - Math.abs(Math.sin(this.frameCount) / 3) / 2;
            this.yVal = 1 + Math.abs(Math.sin(this.frameCount) / 2) / 2;
            this.myClip.scaleY = this.yVal;
            this.myClip.y = 0 - this.yVal * this.myClip.height * 0.6 + 30;
         }
      }
      
      public function byebye(param1:Event = null) : void
      {
         removeChild(this.myClip);
      }
   }
}
