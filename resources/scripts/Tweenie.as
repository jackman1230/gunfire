package
{
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class Tweenie extends Sprite
   {
       
      
      protected var startPos:Number = 0;
      
      protected var endPos:Number = 0;
      
      protected var speed:Number = 4;
      
      protected var callBack:Function = null;
      
      protected var tag:String = "";
      
      protected var initialDistance:Number = 0;
      
      protected var counter:int = 0;
      
      protected var velo:Number = 0;
      
      protected var ticked:Boolean = false;
      
      protected var sign:int = 1;
      
      public var finished:Boolean = false;
      
      protected var outPos:Number = 0;
      
      public var tweenable:Sprite;
      
      public var xMode:Boolean = true;
      
      public function Tweenie()
      {
         super();
      }
      
      public function onFrame(param1:Event = null) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:* = undefined;
         if(!this.finished)
         {
            if(!this.ticked)
            {
               this.counter = this.counter + this.speed;
               if(this.counter > 90)
               {
                  this.ticked = true;
                  this.counter = 90;
                  this.velo = 10 * this.speed;
               }
               _loc2_ = Math.cos(this.counter * (Math.PI / 180));
               _loc3_ = _loc2_ * this.initialDistance;
               this.outPos = this.endPos - _loc3_;
            }
            else
            {
               this.counter = this.counter + 2 * this.speed;
               this.velo = this.velo * 0.94;
               this.outPos = this.endPos + Math.cos(this.counter * (Math.PI / 180)) * this.velo * this.sign;
               if(this.counter >= 360 + 90)
               {
                  this.counter = 360 + 90;
                  removeEventListener(Event.ENTER_FRAME,this.onFrame);
                  this.finished = true;
               }
            }
            if(this.callBack != null)
            {
               if(this.tag != "")
               {
                  this.callBack(this.outPos,this.tag);
               }
               else
               {
                  this.callBack(this.outPos);
               }
            }
            else
            {
               removeEventListener(Event.ENTER_FRAME,this.onFrame);
            }
         }
         else
         {
            removeEventListener(Event.ENTER_FRAME,this.onFrame);
         }
      }
      
      public function disable() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.onFrame);
      }
      
      private function setPos(param1:Number) : void
      {
         if(this.tweenable != null)
         {
            if(this.xMode)
            {
               this.tweenable.x = param1;
            }
            else
            {
               this.tweenable.y = param1;
            }
         }
         else
         {
            removeEventListener(Event.ENTER_FRAME,this.onFrame);
         }
      }
      
      public function tweenSprite(param1:Number, param2:Number, param3:Sprite, param4:Boolean = true, param5:Boolean = true, param6:Number = 4, param7:Boolean = true) : Tweenie
      {
         this.tweenable = param3;
         this.xMode = param4;
         this.tween(param1,param2,this.setPos,param5,param6,"",param7);
         return this;
      }
      
      public function tween(param1:Number, param2:Number, param3:Function, param4:Boolean = true, param5:Number = 4, param6:String = "", param7:Boolean = true) : *
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onFrame);
         this.addEventListener(Event.ENTER_FRAME,this.onFrame);
         this.startPos = param1;
         this.endPos = param2;
         this.speed = param5;
         this.callBack = param3;
         this.tag = param6;
         this.initialDistance = this.endPos - this.startPos;
         this.velo = 0;
         this.counter = 0;
         if(this.initialDistance < 0)
         {
            this.sign = -1;
         }
         else
         {
            this.sign = 1;
         }
         if(!param4)
         {
            this.sign = this.sign * -1;
         }
         this.ticked = false;
         this.finished = false;
         this.outPos = this.startPos;
         if(!param7)
         {
            this.disable();
         }
      }
   }
}
