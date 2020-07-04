package objects
{
   import flash.display.MovieClip;
   
   public class cDetailCanvasOff extends cDetailCanvas
   {
       
      
      public function cDetailCanvasOff(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function getStats() : void
      {
         super.getStats();
         var _loc1_:int = 0;
         while(_loc1_ < bClip.numChildren)
         {
            if(bClip.getChildAt(_loc1_) is MovieClip)
            {
               (bClip.getChildAt(_loc1_) as MovieClip).stop();
            }
            _loc1_++;
         }
      }
   }
}
