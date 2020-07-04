package
{
   import flash.events.Event;
   
   public class Thwomp extends Tweenie
   {
       
      
      var isNeg:Boolean = false;
      
      public function Thwomp()
      {
         super();
      }
      
      override public function onFrame(param1:Event = null) : void
      {
         if(!finished)
         {
            if(!ticked)
            {
               outPos = startPos;
               speed = 5;
               ticked = true;
            }
            speed = speed * 1.2;
            outPos = startPos + speed;
            if(startPos + speed < endPos)
            {
               outPos = startPos + speed;
            }
            else
            {
               outPos = endPos;
               removeEventListener(Event.ENTER_FRAME,this.onFrame);
               finished = true;
            }
            if(callBack != null)
            {
               if(tag != "")
               {
                  callBack(outPos,tag);
               }
               else
               {
                  callBack(outPos);
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
   }
}
